//
//  FileUtils.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 09/01/22.
//

import Foundation

class FileUtils {
    static var defaultDestinationURL: URL? {
        try? getUserDownloadsURL()
    }
    
    class func getUserDownloadsURL() throws -> URL {
        let fileManager = FileManager.default
        return try fileManager.url(for: .downloadsDirectory,
                                      in: .userDomainMask,
                                      appropriateFor: nil,
                                      create: false)
    }
}
