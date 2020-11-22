//
//  ValidateGameTileViewModel.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/19/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import SwiftUI
import Combine

class PostGameTileViewModel: ObservableObject {
    private let service = PostGameItemService()
    private var postGameRequest: PostGameItem? {
        didSet {
            if postGameRequest?.matched == true {
                status = .matched
            } else if postGameRequest?.matched == false {
                status = .didNotMatch
            } else {
                status = .yetToStart
            }
        }
    }
    
    @Published var requestProcessing: Bool = false
    var cancellable: AnyCancellable?
    @Published var status: GameTileStatus = .yetToStart

    func postGameItems(_ model: GameItem, imgae: UIImage, completionBlock: @escaping (_ success: Bool) -> Void) {
        self.requestProcessing = true
        let imageData: Data? = imgae.jpegData(compressionQuality: 0.6)
        let base64EncodedImageString = imageData?.base64EncodedString(options: .lineLength64Characters)
        let requestModel = PostGameItemRequestModel(itemName: model.name, imageContent: base64EncodedImageString)
        cancellable = service.postGameData(with: requestModel).sink(receiveCompletion: { _ in },
                                                                    receiveValue: { result in
                                                                        print("Post Game Item result:\(result.matched)")
                                                                        self.postGameRequest = result
                                                                        self.requestProcessing = false
                                                                        completionBlock(result.matched)
        })
    }
}
