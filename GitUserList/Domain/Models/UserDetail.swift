//
//  UserDetail.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
struct UserDetails: Codable, Identifiable {
    let login: String
    let id: Int
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}

enum TypeEnum: String, Codable {
    case user = "User"
}

typealias Users = [UserDetails]
