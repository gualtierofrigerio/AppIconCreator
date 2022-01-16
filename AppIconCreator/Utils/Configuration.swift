//
//  Configuration.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 09/01/22.
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

class Configuration {
    class func loadConfigurationFromArray(_ array: [[String: String]]) -> [Icon] {
        var icons: [Icon] = []
        for dictionary in array {
            if let icon = Icon.loadFromDictionary(dictionary) {
                icons.append(icon)
            }
        }
        return icons
    }
}

let defaultIconConfiguration: [Icon] = [
    Icon(idiom: "ipad",   scale: "1x", size: CGSize(width: 20, height: 20), suffix: "-20x20@1x"),
    Icon(idiom: "iphone", scale: "2x", size: CGSize(width: 40, height: 40), suffix: "-20x20@2x"),
    Icon(idiom: "iphone", scale: "3x", size: CGSize(width: 60, height: 60), suffix: "-20x20@3x"),
    Icon(idiom: "ipad",   scale: "1x", size: CGSize(width: 29, height: 29),   suffix: "-29x29@1x"),
    Icon(idiom: "iphone", scale: "2x", size: CGSize(width: 58, height: 58),   suffix: "-29x29@2x"),
    Icon(idiom: "iphone", scale: "3x", size: CGSize(width: 87, height: 87),   suffix: "-29x29@3x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 40, height: 40),   suffix: "-40x40@1x"),
    Icon(idiom: "iphone", scale: "2x", size: CGSize(width: 80, height: 80),   suffix: "-40x40@2x"),
    Icon(idiom: "iphone", scale: "3x", size: CGSize(width: 120, height: 120), suffix: "-40x40@3x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 57, height: 57),   suffix: "-57x57@1x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 114, height: 114), suffix: "-57x57@1x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 60, height: 60),   suffix: "-60x60@1x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 120, height: 120), suffix: "-60x60@2x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 180, height: 180), suffix: "-60x60@3x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 76, height: 76),   suffix: "-76x76@1x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 152, height: 152), suffix: "-76x76@2x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 228, height: 228), suffix: "-76x76@3x"),
    Icon(idiom: "ipad", scale: "1x", size: CGSize(width: 167, height: 167), suffix: "-83x83@2x")
]

