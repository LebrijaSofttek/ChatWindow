//
//  ContentView.swift
//  ChatWindow
//
//  Created by Godin on 24/09/24.
//
import MarkdownUI
import SwiftUI

struct ContentView: View {
    @State private var mdString: String = "None Selected"
    var body: some View {
        VStack{
            Text(mdString == "" ? "None Selected" : mdString)
            Button(action: {
                print("Click!")
                loadMarkdownFromDefaults()
            }, label: {
                Text("Refresh!")
            })
        }
        .onAppear {
            mdString = ""
        }
    }
    private func loadMarkdownFromDefaults() {
            if let sharedDefaults = UserDefaults(suiteName: "group.com.softtek.extension.shared"),
               let savedString = sharedDefaults.string(forKey: "selectedMarkdown") {
                mdString = savedString
                print("Loaded: \(savedString)")
            } else {
                print("Failed to load from shared UserDefaults.")
            }
        }
}

#Preview {
    ContentView()
}
