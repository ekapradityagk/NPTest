//
//  Connection.swift
//  NPTest
//
//  Created by Eka Praditya on 26/07/23.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func fetchUsers(withToken token: String) {
        let url = URL(string: "https://api.cloudsploit.com/v2/users")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue(token, forHTTPHeaderField: "X-API-Key")
                request.setValue(token, forHTTPHeaderField: "X-Signature")
                request.setValue("12345678910", forHTTPHeaderField: "X-Timestamp")
//                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
        URLSession.shared.dataTask(with: request) { data, response, error in
                   DispatchQueue.main.async {
                       if let error = error {
                           print("Error fetching users: \(error)")
                           return
                       }
                       
                       guard let data = data else {
                           print("No data received for users")
                           return
                       }
                       
                       do {
                           let decoder = JSONDecoder()
                           let userResponse = try decoder.decode(UserResponse.self, from: data)
                           self.users = userResponse.users
                       } catch {
                           print("Error decoding users: \(error)")
                       }
                   }
               }.resume()
    }
}

class LoginViewModel: ObservableObject {
    @Published var responseMessage: String = ""
    @Published var authToken: String = ""
    
    private let baseUrl = "https://api.cloudsploit.com/v2/signin"

    func login(email: String, pass: String) {

        let url = URL(string: baseUrl)!
        

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let body: [String: Any] = [
            "email": email,
            "password": pass
        ]
        print("body \(body)")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            responseMessage = "Error: \(error.localizedDescription)"
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                   DispatchQueue.main.async {
                       if let error = error {
                           self.responseMessage = "Error: \(error.localizedDescription)"
                           return
                       }
                       
                       guard let data = data else {
                           self.responseMessage = "Error: No data received"
                           return
                       }

                       if let jsonString = String(data: data, encoding: .utf8) {
                                           print("Raw JSON Response: \(jsonString)")
                                       }
                       
                       do {
                           let json = try JSONSerialization.jsonObject(with: data, options: [])

                           print("Raw JSON Response: \(json)")
                           

                           if let responseDict = json as? [String: Any] {
                               if let responseData = responseDict["data"] as? [String: Any] {
//                                   print("response data \(responseData["token"])")

                                   if let token = responseData["token"] as? String {
                                       self.authToken = token
                                       self.responseMessage = token
                                   } else {
                                       self.authToken = ""
                                       self.responseMessage = "Token not found in response"
                                   }
                                   

                               }
                           } else {
                               self.responseMessage = "Unknown response format"
                           }
                       } catch {
                           self.responseMessage = "Error: \(error.localizedDescription)"
                       }
                   }
               }.resume()
    }
}

struct User: Codable {
    let id: Int
    let account_admin: String
    let email: String
}

struct UserResponse: Codable {
    let users: [User]
}
