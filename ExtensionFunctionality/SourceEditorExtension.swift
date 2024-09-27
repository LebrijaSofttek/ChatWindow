//
//  SourceEditorExtension.swift
//  ExtensionFunctionality
//
//  Created by Godin on 24/09/24.
//

import Foundation
import XcodeKit
import AppKit
import SwiftUI

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    @StateObject var bundles = GlobalVariables()
    
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
        if !isAppRunning(bundleIdentifier: bundles.menuId){
            launchApp(bundleIdentifier: bundles.menuId)
            print("Launched Menu")
        }
    }
    /*
     var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
     // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
     return []
     }
     */
    
}
//EMBED AND SIGN

/*
 seleccionas texto
 seleccionas Frida GPT Tests
 sale el texto seleccionado y es modificable
 select lenguage and test framework
 if you have example test, input it as reference
 click generate
 generates happy paths and edge cases as code
 button that can create a folder named tests and generates new file
*/
