//
//  PostGameItemService.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/19/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import Combine

class PostGameItemService {
    
    private var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "hoi4nusv56.execute-api.us-east-1.amazonaws.com"
        components.path = "/iositems/items"
        return components
    }
    
    func postGameData(with model: PostGameItemRequestModel) -> AnyPublisher <PostGameItem, Error> {
        var requestModel = URLRequest(url: components.url!)
        requestModel.httpMethod  = "POST"
        requestModel.httpBody = model.requestData!
        return URLSession.shared.dataTaskPublisher(for: requestModel)
            .map { $0.data }
            .decode(type: PostGameItem.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension Encodable {
    var requestData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
