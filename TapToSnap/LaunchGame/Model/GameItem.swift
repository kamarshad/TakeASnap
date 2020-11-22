//
//  GameItem.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/19/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import SwiftUI

struct GameItem: Codable, Hashable, GameItemDisplayable {
    var id: Int
    var name: String
}

protocol GameItemDisplayable {
    var id: Int { get }
    var name: String { get }
}

struct PostGameItem: Codable, Hashable {
    var matched: Bool
}

struct PostGameItemRequestModel: Codable {
    var itemName: String // name of the game item againts which image was captured
    var imageContent: String? // Base64String content
    
    private enum CodingKeys: String, CodingKey {
        case itemName = "ImageLabel"
        case imageContent = "Image"
    }
}
