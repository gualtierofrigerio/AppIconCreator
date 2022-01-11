//
//  ImageUtils.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 09/01/22.
//

import AppKit
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

/// Utility class to load, resize and save PNG images with CoreGraphics
class ImageUtils {
    /// Tries to create a CGImage from a PNG file at the given URL
    /// - Parameter url: The url of the PNG image
    /// - Returns: The optional CGImage
    class func loadCGImage(fromUrl url: URL) -> CGImage? {
        guard let provider = CGDataProvider(url: url as CFURL) else {
            print("Error creating a data provider for url \(url)")
            return nil
        }
        return CGImage(pngDataProviderSource: provider,
                            decode: nil,
                            shouldInterpolate: false,
                            intent: CGColorRenderingIntent.defaultIntent)
    }
    
    /// Resizes a CGImage to the given CGSize
    /// - Parameters:
    ///   - image: The CGImage to resize
    ///   - size: The image size
    /// - Returns: A CGImage of the given size if the conversion was successful
    class func resizeImage(_ image: CGImage, size: CGSize) -> CGImage? {
        guard let space = image.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB) else { return nil }
        let bitmapInfo: UInt32 = 5 // noneSkipLast
        let context = CGContext(data: nil,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: image.bitsPerComponent,
                                bytesPerRow: image.bytesPerRow,
                                space: space,
                                bitmapInfo: bitmapInfo)
        context?.interpolationQuality = .high
        context?.setFillColor(NSColor.white.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        context?.draw(image, in: CGRect(origin: .zero, size: size))
        let resizedImage = context?.makeImage()
        return resizedImage
    }
    
    /// Save a CGImage to a PNG file
    /// - Parameters:
    ///   - image: The CGImage to save
    ///   - toUrl: URL of the PNG file
    /// - Returns: True if the image was saved, false in case of error
    class func savePNGImage(image:CGImage, toUrl: URL) -> Bool {
        guard let destination = CGImageDestinationCreateWithURL(toUrl as CFURL,
                                                                UTType.png.identifier as CFString,
                                                                1,
                                                                nil) else { return false }
        CGImageDestinationAddImage(destination, image, nil)
        return CGImageDestinationFinalize(destination)
    }
}
