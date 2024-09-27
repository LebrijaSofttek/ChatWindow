//
//  SourceEditorCommand.swift
//  ExtensionFunctionality
//
//  Created by Godin on 24/09/24.
//

import Foundation
import XcodeKit
import SwiftUI

class OpenChatOnSelectedText: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        print("Starting command execution...")
        
        //check text is selected
        guard let selections = invocation.buffer.selections as? [XCSourceTextRange],let selection = selections.first else {
            let error = NSError(domain: "SourceEditorCommandError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No selection found."])
            completionHandler(error)
            return
        }
        
        //set range
        let startIndex = selection.start.line
        let endIndex = selection.end.line
        let selectedRange = NSRange(location: startIndex, length: endIndex - startIndex + 1)
                
        //check selected lines
        guard let selectedLines = invocation.buffer.lines.subarray(with: selectedRange) as? [String] else {
            let error = NSError(domain: "SourceEditorCommandError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve selected lines."])
            completionHandler(error)
            return
        }
        
        // Add Markdown formatting and assign it to UserDefaults
        let text = selectedLines.joined(separator: "\n")
        let pasteboardString = "```\n\(text)\n```"
        
        // Save to UserDefaults
        if let sharedDefaults = UserDefaults(suiteName: sharedGroupId) {
            sharedDefaults.set(pasteboardString, forKey: "selectedMarkdown")
            print("Markdown text saved to shared UserDefaults.")
        } else {
            print("Failed to access shared UserDefaults.")
        }
        
        // launch chat window if not open
        if !isAppRunning(bundleIdentifier: chatWindowId){
            launchApp(bundleIdentifier: chatWindowId)
            print("Launched ChatWindow")
        }else{
            bringAppToFront(bundleIdentifier: chatWindowId)
        }
        completionHandler(nil)
    }
}
