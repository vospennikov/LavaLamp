//
//  FluidView.swift
//  LavaLamp
//
//  Created by Mikhail Vospennikov on 05.08.2023.
//

import Foundation
import QuartzCore
import SwiftUI
import UIKit

protocol FluidViewDelegate: AnyObject {
    func updateBlur(_ value: CGFloat) async
}

final class FluidView: UIView {
    var speed: CGFloat
    let blobsLayer = EntireViewLayer()
    let backlightsLayer = EntireViewLayer()
    private var timers: [Timer] = []
    weak var delegate: FluidViewDelegate?
    
    init(blobs: [UIColor], backlights: [UIColor], speed: CGFloat) {
        self.speed = speed
        super.init(frame: .zero)
        
        setupLayers()
        configureLayers(with: blobs, layer: blobsLayer)
        configureLayers(with: backlights, layer: backlightsLayer)
        animateLayers(with: speed)
    }
    
    deinit {
        timers.forEach { $0.invalidate() }
        timers.removeAll()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blobsLayer.frame = bounds
        backlightsLayer.frame = bounds
        Task { await updateBlurEffect() }
    }
    
    private func setupLayers() {
        guard let compositingFilter = CIFilter(name: "CIOverlayBlendMode") else {
            fatalError("Unable to create CIOverlayBlendMode filter")
        }
        backlightsLayer.compositingFilter = compositingFilter
        layer.addSublayer(blobsLayer)
        layer.addSublayer(backlightsLayer)
    }
    
    func configureLayers(with colors: [UIColor], layer: CALayer) {
        colors.forEach {
            layer.addSublayer(BlobLayer(color: $0))
        }
    }
    
    func animateLayers(with speed: CGFloat) {
        timers.forEach { $0.invalidate() }
        timers.removeAll()
        
        self.speed = speed
        guard speed > 0 else { return }
        
        let allBlobs = (blobsLayer.sublayers ?? []) + (backlightsLayer.sublayers ?? [])
        for case let blobLayer as BlobLayer in allBlobs {
            let timer = Timer.scheduledTimer(
                withTimeInterval: .random(in: 0.8 / speed ... 1.2 / speed), repeats: true
            ) { _ in
                Task { await blobLayer.animateLayer(with: speed) }
            }
            timers.append(timer)
        }
    }
    
    private func updateBlurEffect() async {
        await delegate?.updateBlur(min(frame.width, frame.height))
    }
}
