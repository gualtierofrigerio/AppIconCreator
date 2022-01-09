//
//  ImageView.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 08/01/22.
//

import AppKit
import SwiftUI

struct ImageView: View {
    var nsImage: NSImage?
    
    var body: some View {
        if let image = nsImage {
            Image(nsImage: image)
                .resizable()
                .scaledToFit()
        }
        else {
            Image(systemName: "photo")
                .font(.largeTitle)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
