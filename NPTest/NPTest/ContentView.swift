//
//  ContentView.swift
//  NPTest
//
//  Created by Eka Praditya on 26/07/23.
//

import SwiftUI

var iPadWidth       : CGFloat = UIScreen.main.bounds.width  //768
var iPadHeight      : CGFloat = UIScreen.main.bounds.height //1004 --> 1024
var borderWidth     : CGFloat = 0

struct ContentView: View {
    @State var pageState = "login"

    var body: some View {
        navigationMenu(viewModel: LoginViewModel(),sActiveMenu: pageState)
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
