//
//  FileUtils.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 09/01/22.
//

import AppKit
import Foundation

class FileUtils {
    static var defaultDestinationURL: URL? {
        try? getUserDownloadsURL()
    }
    
    class func changeDestination(completion: @escaping (URL?) -> Void) {
        let dialog = NSOpenPanel();
        
        dialog.title                    = "Choose a directory"
        dialog.allowsMultipleSelection  = false
        dialog.canChooseDirectories     = true
        dialog.canChooseFiles           = false
        dialog.canCreateDirectories     = true
        dialog.showsResizeIndicator     = true
        dialog.showsHiddenFiles         = false
        
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            if let url = dialog.url {
                completion(url)
            }
        } else {
            print("user cancelled")
            completion(nil)
        }
    }
    
    class func getUserDownloadsURL() throws -> URL {
        let fileManager = FileManager.default
        return try fileManager.url(for: .downloadsDirectory,
                                      in: .userDomainMask,
                                      appropriateFor: nil,
                                      create: false)
    }
}
