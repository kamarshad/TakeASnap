//
//  GameTileView.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/18/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import SwiftUI


struct GameTileView: View {
    @ObservedObject var postGameInfoViewModel = PostGameTileViewModel()
    var model: GameItem
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage?
    @State private var isGameOver: Bool = UserDefaults.standard.isGameOver
    var completionBlock: (_ success: Bool) -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Image(self.postGameInfoViewModel.status.imageName)
                    .resizable()
                    .onTapGesture {
                        if self.postGameInfoViewModel.status != .matched && ImagePickerView.isCameraAvailable && self.isGameOver == true && !self.postGameInfoViewModel.requestProcessing {
                            self.showImagePicker.toggle()
                        }
                }
                .overlay(TextOverlay(message: self.model.name, padding: 5.0), alignment: .bottom)
                if self.image != nil {
                    LoaderView(isShowing: self.$postGameInfoViewModel.requestProcessing) {
                        Image(uiImage: self.image!)
                            .resizable()
                            .onTapGesture {
                                if self.postGameInfoViewModel.status != .matched && ImagePickerView.isCameraAvailable && self.isGameOver && !self.postGameInfoViewModel.requestProcessing {
                                    self.showImagePicker.toggle()
                                }
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(self.postGameInfoViewModel.status.borderColor, lineWidth: 4))
                    .overlay(TextOverlay(message: self.model.name, padding: 2.0, height: 52), alignment: .bottom)
                    .if(self.postGameInfoViewModel.status == .didNotMatch && self.isGameOver) { view in
                        view.overlay(TextOverlay(message: Constants.tryAgain, padding: 2.0, height: 52, font: .font4, bgColor: .clear), alignment: .center)
                    }
                }
            }
        }.sheet(isPresented: self.$showImagePicker) {
            ImagePickerView() { image in
                self.postGameInfoViewModel.status = .yetToStart
                self.image = image
                self.postGameInfoViewModel.postGameItems(self.model, imgae: image, completionBlock: self.completionBlock)
            }
        }
    }
}

struct TextOverlay: View {
    var message: String
    var padding: CGFloat
    var height: CGFloat = 40
    var font: Font = Font.font3
    var bgColor: Color = Color.playGameTitleConainerBGColor
    
    var body: some View {
        VStack{
            VStack {
                Text(message)
                    .font(font)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: height)
                    .padding(.bottom, padding)
                    .foregroundColor(.white)
            }
        }.background(bgColor)
            .padding(.all, padding)
    }
}
