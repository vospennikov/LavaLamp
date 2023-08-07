//
//  LavaLamp.swift
//  LavaLamp
//
//  Created by Mikhail Vospennikov on 05.08.2023.
//

import SwiftUI

struct LavaLamp: View {
    private var blobs: [UIColor]
    private var backlights: [UIColor]
    @State private var blur: CGFloat = 0.8
    
    init(blobs: [UIColor], backlights: [UIColor]) {
        self.blobs = blobs
        self.backlights = backlights
    }
    
    var body: some View {
        FluidViewRepresentable(blobs: blobs, backlights: backlights, speed: 0.5, blur: $blur)
            .blur(radius: pow(blur, 0.8), opaque: false)
            .accessibility(hidden: true)
    }
}

extension LavaLamp {
    @MainActor
    struct FluidViewRepresentable: UIViewRepresentable {
        var blobs: [UIColor]
        var backlights: [UIColor]
        var speed: CGFloat
        @Binding var blur: CGFloat

        func makeUIView(context: Context) -> FluidView {
            makeView(context: context)
        }
        func updateUIView(_ view: FluidView, context: Context) {
            configureView(view, context: context)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(blobs: blobs, backlights: backlights, speed: speed, blur: $blur)
        }
        
        private func makeView(context: Context) -> FluidView {
            context.coordinator.view
        }
        
        private func configureView(_ view: FluidView, context: Context) {
            context.coordinator.create(blobs: blobs, backlights: backlights)
            context.coordinator.updateAnimationSpeed(speed)
        }
    }
    
    @MainActor
    final class Coordinator: FluidViewDelegate {
        var blobs: [UIColor]
        var backlights: [UIColor]
        var speed: CGFloat
        var blur: Binding<CGFloat>
        
        var view: FluidView
        
        init(
            blobs: [UIColor],
            backlights: [UIColor],
            speed: CGFloat,
            blur: Binding<CGFloat>
        ) {
            self.blobs = blobs
            self.backlights = backlights
            self.speed = speed
            self.blur = blur
            self.view = FluidView(blobs: blobs, backlights: backlights, speed: speed)
            self.view.delegate = self
        }
        
        func create(blobs: [UIColor], backlights: [UIColor]) {
            guard self.blobs != blobs || self.backlights != backlights else { return }
            
            self.blobs = blobs
            self.backlights = backlights
            
            view.configureLayers(with: blobs, layer: view.blobsLayer)
            view.configureLayers(with: backlights, layer: view.backlightsLayer)
            
            guard self.speed != speed else { return }
            view.animateLayers(with: speed)
        }
        
        func updateAnimationSpeed(_ newSpeed: CGFloat) {
            guard speed != newSpeed else { return }
            
            speed = newSpeed
            view.animateLayers(with: newSpeed)
        }
        
        func updateBlur(_ value: CGFloat) {
            blur.wrappedValue = value
        }
    }
}
