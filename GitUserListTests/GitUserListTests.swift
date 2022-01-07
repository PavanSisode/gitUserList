//
//  GitUserListTests.swift
//  GitUserListTests
//
//  Created by Pavan Shisode on 07/01/22.
//

import XCTest
import Combine

@testable import GitUserList

class GitUserListTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()
    override  func tearDown() {
        subscriptions = []
    }
    
    func testFetchImagesData() {
        let mock = MockedUsersService(networker: Networker())
        let viewModel = UserViewModel(userService: mock)
        XCTAssertEqual(viewModel.users.count, 0, "Starting with no user data")
        
        let promise = expectation(description: "Fetching single user meta data")
        viewModel.fetchUsers()
        viewModel.$users.sink { (completion) in
            XCTFail()
        } receiveValue: { (values) in
            if values.count == 1 {
                XCTAssertEqual(values.first?.id, 101)
                XCTAssertEqual(values.first?.login, "pavan")
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        wait(for: [promise], timeout: 1)
    }
}
