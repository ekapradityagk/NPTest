//
//  navigationMenu.swift
//  NPTest
//
//  Created by Eka Praditya on 26/07/23.
//

import SwiftUI

struct navigationMenu: View {
    
    @ObservedObject var viewModel = LoginViewModel()

    @State var sActiveMenu : String = ""

    
    var body: some View {
        VStack{
            if sActiveMenu == "login"{
                LoginView(sActiveMenu: $sActiveMenu)
            }else if sActiveMenu == "userDisplay"{
                UserListView(sActiveMenu: $sActiveMenu)
            }
        }
    }
}

struct navigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        navigationMenu()
    }
}
