//
//  BlobLayer.swift
//  LavaLamp
//
//  Created by Mikhail Vospennikov on 05.08.2023.
//

import UIKit
import QuartzCore

@MainActor
final class BlobLayer: CAGradientLayer {
    private let positionRange = CGFloat(0.0)...CGFloat(1.0)
    private let sizeRange = CGFloat(0.15)...CGFloat(0.75)
    private let ratioRange = CGFloat(0.25)...CGFloat(1.75)
    private let colorLocations = Array<NSNumber>([0.0, 0.70, 1.0])
    
    init(color: UIColor) {
        super.init()
        type = .radial
        setColor(color)
        let position = generateRandomPosition()
        let radius = calculateRandomRadius()
        startPoint = position
        endPoint =  CGPoint(x: position.x + radius.x, y: position.y + radius.y)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    func generateRandomPosition() -> CGPoint {
        CGPoint(
            x: max(min(CGFloat.random(in: positionRange), 1), 0),
            y: max(min(CGFloat.random(in: positionRange), 1), 0)
        )
    }
    
    func calculateRandomRadius() -> CGPoint {
        let size = CGFloat.random(in: sizeRange)
        let viewRatio = frame.width / frame.height
        let safeRatio = max(viewRatio.isNaN ? 1 : viewRatio, 1)
        let ratio = safeRatio * CGFloat.random(in: ratioRange)
        return CGPoint(x: size, y: size * ratio)
    }
    
    func animateLayer(with speed: CGFloat) {
        guard speed > 0 else { return }
        self.removeAllAnimations()
        
        let position = generateRandomPosition()
        animateProperty(keyPath: "startPoint", newValue: position, speed: speed)
        
        let radius = calculateRandomRadius()
        let endPoint = CGPoint(x: position.x + radius.x, y: position.y + radius.y)
        animateProperty(keyPath: "endPoint", newValue: endPoint, speed: speed)
        
        let opacityValue = Float.random(in: 0.5...1)
        animateProperty(keyPath: "opacity", newValue: opacityValue, speed: speed)
    }
    
    func createAnimation(currentValue: Any, toValue: Any, speed: CGFloat) -> CASpringAnimation {
        let animation = CASpringAnimation()
        animation.mass = 10 / speed
        animation.damping = 50
        animation.duration = 1 / speed
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.fromValue = currentValue
        animation.toValue = toValue
        return animation
    }

    func animateProperty(keyPath: String, newValue: Any, speed: CGFloat) {
        let currentLayer = presentation() ?? self
        if let currentValue = currentLayer.value(forKeyPath: keyPath) {
            let animation = createAnimation(currentValue: currentValue, toValue: newValue, speed: speed)
            setValue(newValue, forKeyPath: keyPath)
            add(animation, forKey: keyPath)
        }
    }

    func setColor(_ color: UIColor) {
        colors = [color.cgColor, color.cgColor, color.withAlphaComponent(0).cgColor]
        locations = colorLocations
    }
}
