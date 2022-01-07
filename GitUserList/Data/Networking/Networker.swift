//
//  Networker.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    func get<T>(type: T.Type,
                url: URL) -> AnyPublisher<T, Error> where T: Decodable
}

final class Networker: NetworkProtocol {
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        let urlrequest = URLRequest(url: url)
        return URLSession.shared.dataTaskPublisher(for: urlrequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
