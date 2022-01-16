//
//  IconCreator.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 09/01/22.
//

import Foundation

class IconCreator {
    class func createIcons(fromImageAtURL imageURL: URL,
                           destinationURL: URL) throws {
        guard let cgImage = ImageUtils.loadCGImage(fromUrl: imageURL) else {
            throw IconCreatorError.loadImage
        }
        let icons = Configuration.loadIcons()
        try createIcons(icons,
                    fromImage: cgImage,
                    prefix: "AppIcon",
                    destinationURL: destinationURL)
    }
    
    class func createIcons(_ icons: [Icon],
                           fromImage originalImage: CGImage,
                           prefix: String,
                           destinationURL: URL) throws {
        var url: URL
        for icon in icons {
            url = destinationURL
            url.appendPathComponent(prefix + icon.suffix)
            url.appendPathExtension("png")
            guard let resizedImage = ImageUtils.resizeImage(originalImage, size: icon.size) else {
                throw IconCreatorError.resize
            }
            let result = ImageUtils.savePNGImage(image: resizedImage, toUrl: url)
            if result == false {
                throw IconCreatorError.save
            }
        }
        url = destinationURL
        url.appendPathComponent("Contents")
        url.appendPathExtension("json")
        do {
            try writeContents(forIcons: icons, atURL: url, prefix: prefix)
        }
        catch {
            throw IconCreatorError.save
        }
    }
    
    class func writeContents(forIcons icons: [Icon],
                             atURL url: URL,
                             prefix: String) throws {
        let iconsArray: [[String: String]] = icons.map {
            $0.toDictionary(prefix: prefix)
        }
        let data = try JSONSerialization.data(withJSONObject: iconsArray, options: .prettyPrinted)
        try data.write(to: url)
    }
}
