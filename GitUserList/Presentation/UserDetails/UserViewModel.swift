//
//  UserViewModel.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users = [UserDetails]()
    @Published public var errorMessage: String = String()
    
    var isUsersListFull = false
    var currentPage = 0
    let perPage = 10
    
    private var cancellable = Set<AnyCancellable>()
    private var userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    func fetchUsers() {
        userService.getUsers(paggination: Paggination(currentPage: currentPage+1, perPage: perPage))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.feedingError(error)
                case .finished:break
                }
            } receiveValue: { [weak self] users in
                guard let self = self else { return }
                self.currentPage += 1
                self.users.append(contentsOf: users)
                if users.count < self.perPage {
                    self.isUsersListFull = true
                }
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Error Handling
    private func feedingError(_ error: Error) {
        self.errorMessage = error.localizedDescription
    }
}
