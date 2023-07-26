//
//  userListView.swift
//  NPTest
//
//  Created by Eka Praditya on 26/07/23.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject private var userListViewModel = UserListViewModel()
    @ObservedObject private var viewModel = LoginViewModel()

    @Binding var sActiveMenu : String

    var body: some View {
        List(userListViewModel.users, id: \.id) { user in
            VStack(alignment: .leading) {
                Text(user.account_admin)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
            }
        }
        .onAppear {
            userListViewModel.fetchUsers(withToken: viewModel.authToken)
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    
    @State static var value = "userDisplay"

    static var previews: some View {
        UserListView(sActiveMenu: $value)
    }
}
