//
//  ContentView.swift
//  NavbarIcon
//
//  Created by Godin on 24/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //App Name
            Text("Frida GPT")
            //quit apps
            Button(action: {
                if !isAppRunning(bundleIdentifier: chatWindowId){
                    launchApp(bundleIdentifier: chatWindowId)
                }
            }, label: {
                Text("open chat")
            })
            Divider()
            //quit apps
            Button(action: {
                if isAppRunning(bundleIdentifier: chatWindowId){
                    closeApp(bundleIdentifier: chatWindowId)
                    print("quit chat")
                }
                NSApp.terminate(nil)
            }, label: {
                Text("quit")
            })
        }
        .padding()
        .onAppear{
            print("Navbar")
        }
    }
}

#Preview {
    ContentView()
}
