//
//  UsersListView.swift
//  GitUserList
//
//  Created by Pavan Shisode on 07/01/22.
//

import SwiftUI
import Foundation

struct UsersListView: View {
    @ObservedObject var viewModel = UserViewModel()
    @State public var showsAlert: Bool = false
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                if viewModel.isUsersListFull == false {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Username: \(user.login)")
                            Text("User Id: \(user.id)")
                        }
                        AsyncImage(urlString: "\(user.avatarURL)",
                                   placeholder: { Text("Loading ...") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(idealHeight: UIScreen.main.bounds.width / 2)
                    }
                    .onAppear {
                        viewModel.fetchUsers()
                    }
                }
            }
            .onAppear {
                viewModel.fetchUsers()
            }
            .onChange(of: viewModel.errorMessage, perform: { value in
                showsAlert = true
            })
            .alert(isPresented: $showsAlert) {
                Alert(title: Text("Alert"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("Ok")))
            }
            .navigationBarTitle("Users")
        }
    }
}
