//
//  ContentView.swift
//  LavaLamp
//
//  Created by Mikhail Vospennikov on 05.08.2023.
//

import SwiftUI

struct ContentView: View {
    let colors: [UIColor] = [
        ColorSet.lapisLazuli,
        ColorSet.carolinaBlue,
        ColorSet.charcoal,
        ColorSet.hunyadiYellow,
        ColorSet.orangePantone,
    ]

    var body: some View {
        ZStack {
            LavaLamp(
                blobs: colors,
                backlights: colors.map { $0.brighter(by: -0.3) }
            )
            .background(Color(with: ColorSet.richBlack))

            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
        }
        .ignoreSafeAreaIfAvailable()
        .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func ignoreSafeAreaIfAvailable() -> some View {
        if #available(iOS 14, *) {
            return self.ignoresSafeArea()
        } else {
            return self
        }
    }
}
