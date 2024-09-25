//
//  SourceEditorCommand.swift
//  ExtensionFunctionality
//
//  Created by Godin on 24/09/24.
//

import Foundation
import XcodeKit
import AppKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        print("Starting command execution...")
        
        //check text is selected
        guard let selections = invocation.buffer.selections as? [XCSourceTextRange],
              let selection = selections.first else {
            let error = NSError(domain: "SourceEditorCommandError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No selection found."])
            completionHandler(error)
            return
        }
        
        //set range
        let startIndex = selection.start.line
        let endIndex = selection.end.line
        let selectedRange = NSRange(location: startIndex, length: endIndex - startIndex + 1)
        
        print("Selected range: \(selectedRange)")
        
        //check selected lines
        guard let selectedLines = invocation.buffer.lines.subarray(with: selectedRange) as? [String] else {
            let error = NSError(domain: "SourceEditorCommandError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve selected lines."])
            completionHandler(error)
            return
        }
        
        // Add Markdown formatting and assign it to UserDefaults
        let text = selectedLines.joined(separator: "\n")
        let pasteboardString = "```\n\(text)\n```"
        
        // Save to UserDefaults (or any shared location)
        if let sharedDefaults = UserDefaults(suiteName: "group.com.softtek.extension.shared") {
            sharedDefaults.set(pasteboardString, forKey: "selectedMarkdown")
            print("Markdown text saved to shared UserDefaults.")
        } else {
            print("Failed to access shared UserDefaults.")
        }
        
        print("Markdown text saved to UserDefaults: \(pasteboardString)")
        
        // Complete the command
        launchWindow()
        completionHandler(nil)
    }
    func launchWindow() -> Void{
        let bundleIdentifier = "com.softtek.geninterfaces.ChatWindow"
        
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
}
