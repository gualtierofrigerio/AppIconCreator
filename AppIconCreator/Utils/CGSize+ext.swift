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
        "\(width)x\(height)"
    }
}
