//
//  ContentView.swift
//  LavaLamp
//
//  Created by Mikhail Vospennikov on 05.08.2023.
//

import SwiftUI

struct ContentView: View {
    let colors: [UIColor] = [.lapisLazuli, .carolinaBlue, .charcoal, .hunyadiYellow, .orangePantone]
    
    var body: some View {
        ZStack {
            LavaLamp(
                blobs: colors,
                backlights: colors.map { $0.brighter(by: -0.3) }
            )
            .background(.richBlack)
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
    
}

#Preview {
    ContentView()
}
