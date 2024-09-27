//
//  QuitAppsCommand.swift
//  ExtensionFunctionality
//
//  Created by Godin on 26/09/24.
//

import Foundation
import XcodeKit

class QuitAppsCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        print("empty function called")
    }
}

