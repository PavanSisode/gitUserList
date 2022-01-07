//
//  UserService.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    var networker: NetworkProtocol { get }
    func getUsers(paggination: Paggination) -> AnyPublisher<Users, Error>
}

final class UserService: UserServiceProtocol {
    let networker: NetworkProtocol
    
    init(networker: NetworkProtocol = Networker()) {
        self.networker = networker
    }
    
    func getUsers(paggination: Paggination) -> AnyPublisher<Users, Error> {
        let endpoint = Endpoint(path: "/users", offset: paggination.currentPage, limit: paggination.perPage)
        
        return networker.get(type: Users.self,
                             url: endpoint.url)
    }
}

struct Paggination {
    let currentPage: Int
    let perPage: Int
    
    init(currentPage: Int, perPage: Int) {
        self.currentPage = currentPage
        self.perPage = perPage
    }
}
