//
//  MainView.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 08/01/22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            Group {
                Text("Create asset folder for app icon")
                    .font(.title)
                Spacer()
                Text("Drag a PNG file below")
                Text(viewModel.warningText)
                    .foregroundColor(Color.red)
                Spacer()
            }
            dragArea
                .onDrop(of: ["public.file-url"], delegate: self)
            Group {
                Spacer()
                Text(viewModel.destinationPath)
                Spacer()
                Button {
                    viewModel.createIcons()
                } label: {
                    Text("Create Icons")
                }
                .disabled(!viewModel.enableButton)
                Spacer()
            }
        }
        .frame(minWidth: 300,
               maxWidth: .infinity,
               minHeight: 300,
               maxHeight: .infinity)
    }
    
    private var dragArea: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .opacity(0.1)
            ImageView(nsImage: viewModel.image)
        }
        .padding()
        .border(Color.gray, width: 1)
        .padding()
    }
}

extension MainView: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        DropUtils.urlFromDropInfo(info) { url in
            if let url = url {
                viewModel.setImage(atURL: url)
            }
        }
        return true
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
