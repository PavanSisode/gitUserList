//
//  UserEndpoint.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
struct Endpoint {
    var path: String
    var offset: Int
    var limit: Int
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = .init(["since": offset,"per_page": limit])
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL componants \(components)")
        }
        return url
    }
}
