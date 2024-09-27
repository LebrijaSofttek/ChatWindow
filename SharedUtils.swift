//
//  SharedUtils.swift
//  NavbarIcon
//
//  Created by Godin on 27/09/24.
//

import Foundation
import AppKit

class GlobalVariables: ObservableObject {
    @Published var chatWindowId: String = "com.softtek.geninterfaces.ChatWindow"
    @Published var menuId: String = "com.softtek.geninterfaces.NavbarIcon"
}

func launchApp(bundleIdentifier: String) -> Void{
    // Retrieve the URL for the application using its bundle identifier
    if let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier) {
        // Create an OpenConfiguration object
        let configuration = NSWorkspace.OpenConfiguration()
        
        // Launch the app
        NSWorkspace.shared.openApplication(at: appURL, configuration: configuration, completionHandler: { (app, error) in
            if let error = error {
                print("Failed to launch the app: \(error)")
            } else {
                print("App launched successfully")
            }
        })
    } else {
        print("App with bundle identifier \(bundleIdentifier) not found")
    }
}

func closeApp(bundleIdentifier: String) {
    let runningApps = NSWorkspace.shared.runningApplications
    if let app = runningApps.first(where: { $0.bundleIdentifier == bundleIdentifier }) {
        if app.terminate() {
            print("\(bundleIdentifier) is quitting gracefully.")
        } else {
            print("Failed to quit \(bundleIdentifier) gracefully. Force quitting.")
            app.forceTerminate()
        }
    } else {
        print("\(bundleIdentifier) is not running.")
    }
}

func isAppRunning(bundleIdentifier: String) -> Bool{
    let runningApps = NSWorkspace.shared.runningApplications
    return runningApps.contains { $0.bundleIdentifier == bundleIdentifier }
}

func bringAppToFront(bundleIdentifier: String) {
    // Find all running applications with the specified bundle identifier
    if let app = NSRunningApplication.runningApplications(withBundleIdentifier: bundleIdentifier).first {
        // Bring the app to the front
        app.activate(options: [.activateAllWindows])
    } else {
        print("App with bundle identifier \(bundleIdentifier) is not running.")
    }
}
