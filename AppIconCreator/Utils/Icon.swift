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
              let sizeStr = dictionary["size"] else { return nil }
        let components = sizeStr.components(separatedBy: "x")
        guard components.count == 2,
              let width = Float(components[0]),
              let height = Float(components[1]) else { return nil }
        var suffixStr: String
        if let str = dictionary["suffix"] {
            suffixStr = str
        }
        else {
            suffixStr = "-" + scaleStr + sizeStr
        }
        return Icon(idiom: idiomStr,
                    scale: scaleStr,
                    size: CGSize(width: CGFloat(width), height: CGFloat(height)),
                    suffix: suffixStr)
    }
}
