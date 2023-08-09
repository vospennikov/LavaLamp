//
//  LavaLampApp.swift
//  LavaLamp
//
//  Created by Mikhail Vospennikov on 05.08.2023.
//

import SwiftUI

@main
struct LavaLampApp {
    static func main() {
        if #available(iOS 14.0, *) {
            LavaLampAppWindowGroup.main()
        } else {
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(SceneDelegate.self))
        }
    }
}
