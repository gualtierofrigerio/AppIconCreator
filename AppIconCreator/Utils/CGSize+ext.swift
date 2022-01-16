//
//  CGSize+ext.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 16/01/22.
//

import Foundation

extension CGSize {
    static func fromString(_ string: String) -> Self? {
        let components = string.components(separatedBy: "x")
        guard components.count == 2,
              let width = Float(components[0]),
              let height = Float(components[1]) else { return nil }
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func toString() -> String {
        var widthStr = "\(width)"
        if width.truncatingRemainder(dividingBy: 1.0) == 0 {
            widthStr = "\(Int(width))"
        }
        var heightStr = "\(height)"
        if height.truncatingRemainder(dividingBy: 1.0) == 0 {
            heightStr = "\(Int(height))"
        }
        return widthStr + "x" + heightStr
    }
}
