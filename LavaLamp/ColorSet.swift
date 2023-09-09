//
//  ColorSet.swift
//  Example
//
//  Created by VOSPENNIKOV Mikhail on 08.08.2023.
//

import SwiftUI
import UIKit

enum ColorSet {
    static let lapisLazuli = UIColor(named: "LapisLazuli")!
    static let carolinaBlue = UIColor(named: "CarolinaBlue")!
    static let charcoal = UIColor(named: "Charcoal")!
    static let hunyadiYellow = UIColor(named: "HunyadiYellow")!
    static let orangePantone = UIColor(named: "OrangePantone")!
    static let richBlack = UIColor(named: "RichBlack")!
}

extension Color {
    init(with uiColor: UIColor) {
        if #available(iOS 15.0, *) {
            self.init(uiColor: uiColor)
        } else {
            self.init(uiColor)
        }
    }
}
