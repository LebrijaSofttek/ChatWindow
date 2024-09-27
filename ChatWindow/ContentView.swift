//
//  ContentView.swift
//  ChatWindow
//
//  Created by Godin on 24/09/24.
//
import MarkdownUI
import SwiftUI
import Combine

class UserDefaultsObserver: ObservableObject {
    @Published var userDefaultString: String = UserDefaults.standard.string(forKey: "selectedMarkdown") ?? ""
    
    private var cancellable: AnyCancellable?

    init() {
        // Observe changes to UserDefaults
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .sink { [weak self] _ in
                self?.userDefaultString = UserDefaults.standard.string(forKey: "selectedMarkdown") ?? ""
            }
    }
}

struct ContentView: View {
    @StateObject private var observer = UserDefaultsObserver()
    @State private var mdString: String = "None Selected"
    var body: some View {
        VStack{
            Text(mdString == "" ? "None Selected" : mdString)
        }
        .onAppear {
            mdString = ""
        }
        .onChange(of: UserDefaults(suiteName: sharedGroupId)?.string(forKey: "selectedMarkdown")) { oldValue, newValue in
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
