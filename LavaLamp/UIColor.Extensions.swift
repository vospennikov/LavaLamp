//
//  UIColor.Extensions.swift
//  LavaLamp
//
//  Created by Mikhail Vospennikov on 05.08.2023.
//

import UIKit

extension UIColor {
    func brighter(by percentage: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(
                red: min(red + percentage, 1.0),
                green: min(green + percentage, 1.0),
                blue: min(blue + percentage, 1.0),
                alpha: alpha
            )
        }
        
        return .clear
    }
}
