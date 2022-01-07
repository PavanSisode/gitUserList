//
//  Array+Extension.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
extension Array where Element == URLQueryItem {
    init<T: LosslessStringConvertible>(_ dictionary: [String: T]) {
        self = dictionary.map({ (key, value) -> Element in
            URLQueryItem(name: key, value: String(value))
        })
    }
}
