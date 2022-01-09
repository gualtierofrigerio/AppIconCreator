//
//  NSImage+ext.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 09/01/22.
//

import AppKit
import Foundation

extension NSImage {
    var isSquare: Bool {
        size.width == size.height
    }
}
