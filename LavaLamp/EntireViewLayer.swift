//
//  EntireViewLayer.swift
//  LavaLamp
//
//  Created by Mikhail Vospennikov on 05.08.2023.
//

import QuartzCore

class EntireViewLayer: CALayer {
    override func layoutSublayers() {
        super.layoutSublayers()
        sublayers?.forEach { layer in
            layer.frame = frame
        }
    }
}
