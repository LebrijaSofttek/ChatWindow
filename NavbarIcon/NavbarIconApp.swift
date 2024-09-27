//
//  NavbarIconApp.swift
//  NavbarIcon
//
//  Created by Godin on 24/09/24.
//

import SwiftUI

@main
struct NavbarIconApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
        } label: {
            let image: NSImage = {
                let ratio = $0.size.height / $0.size.width
                $0.size.height = 18
                $0.size.width = 18 / ratio
                return $0
            }(NSImage(named: "F_FRIDA")!)

            Image(nsImage: image)
        }
    }
}
