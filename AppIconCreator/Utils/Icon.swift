//
//  Icon.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 16/01/22.
//

import Foundation

/// Describes a single image in asset with its size
/// and the suffix to append to the original image name
struct Icon {
    var idiom: String
    var scale: String
    var size: CGSize
    var suffix: String
}

extension Icon {
    static func loadFromDictionary(_ dictionary: [String: String]) -> Self? {
        guard let idiomStr = dictionary["idiom"],
              let scaleStr = dictionary["scale"],
              let sizeStr = dictionary["size"],
              let size = CGSize.fromString(sizeStr) else { return nil }
        var suffixStr: String
        if let str = dictionary["suffix"] {
            suffixStr = str
        }
        else {
            suffixStr = suffix(fromSize: size, scale: scaleStr)
        }
        return Icon(idiom: idiomStr,
                    scale: scaleStr,
                    size: size ,
                    suffix: suffixStr)
    }
    
    static func suffix(fromSize size: CGSize, scale: String) -> String {
        "-" + size.toString() + "@" + scale
    }
    
    func toDictionary(prefix: String) -> [String: String] {
        var dictionary: [String: String] = [:]
        dictionary["idiom"] = idiom
        dictionary["scale"] = scale
        dictionary["size"] = size.toString()
        dictionary["filename"] = prefix + Icon.suffix(fromSize: size, scale: scale) + ".png"
        return dictionary
    }
}
