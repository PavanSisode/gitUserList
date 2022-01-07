//
//  MockedUsersService.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
import Combine

struct MockedUsersService: UserServiceProtocol {
    var networker: NetworkProtocol
    let mockedData = [UserDetails(login: "pavan",
                                  id: 101,
                                  avatarURL: "https://fake.com/avatar/pavan-101")]
    
    func getUsers(paggination: Paggination) -> AnyPublisher<Users, Error> {
        return Just(mockedData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
