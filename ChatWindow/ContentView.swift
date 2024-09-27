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
//            Button(action: {
//                print("Click!")
//                loadMarkdownFromDefaults()
//            }, label: {
//                Text("Refresh!")
//            })
        }
        .onAppear {
            mdString = ""
        }
        .onChange(of: UserDefaults(suiteName: "group.com.softtek.extension.shared")) { oldValue, newValue in
            loadMarkdownFromDefaults()
        }
    }
    private func loadMarkdownFromDefaults() {
            if let sharedDefaults = UserDefaults(suiteName: sharedGroupId),
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
