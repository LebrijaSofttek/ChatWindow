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
            Text("Hello, world!")
            Button(action: {
                print("action!!")
            }, label: {
                Text("Button")
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
