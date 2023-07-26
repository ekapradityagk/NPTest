//
//  loginView.swift
//  NPTest
//
//  Created by Eka Praditya on 26/07/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    @State private var showAlert = false
    @State private var email = "anggi.fp+api@netpoleons.com"
    @State private var password = "Aqua-api1!"
    @State private var alertMessage = ""

    @Binding var sActiveMenu : String

    var body: some View {
        VStack {
            Text("Sign-In")
                .bold()
                .font(.system(size: 30))
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                self.loginButtonTapped()
            }) {
                Text("Login")
            }
            
            Button(action: {
                self.testTokenTapped()
            }) {
                Text("test token")
            }

            .alert(isPresented: $showAlert) {
                Alert(title: Text("Response"), message: Text(viewModel.responseMessage), dismissButton: .default(Text("OK")))
            }
        }
        .frame(width : iPadWidth * 0.9, height : 300)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(.vertical, 40)

    }
    
    private func testTokenTapped(){
        print("auth token = \(viewModel.authToken)")
        sActiveMenu = "userDisplay"
        
    }
    
    private func loginButtonTapped() {
        viewModel.login(email: self.email, pass: self.password)
        showAlert = true
    }
}

struct LoginView_Previews:
    PreviewProvider {
    @State static var value = "login"
    static var previews: some View {
        LoginView(sActiveMenu: $value)
    }
}
