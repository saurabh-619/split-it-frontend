//
//  LoginViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isPasswordVisible = false
    @Published private var isLoading = false
    
    func login(loginRequest: LoginRequest) async {
        guard let encoded = try? JSONEncoder().encode(loginRequest) else {
            debugPrint("couldn't encode the request object")
            return
        }
        
        guard let url = Constants.loginUrl else {
            debugPrint("couldn't get the url")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let response = try JSONDecoder().decode(LoginResponse.self, from: data)
            
            print(response)
            if(response.ok) {
                UserDefaults.standard.setValue(response.token!, forKey: "token")
            }
        } catch  {
            debugPrint("couldnt make login request.")
            debugPrint(error.localizedDescription)
        }
    }
    
    func printToken() {
        print("token -------> \n", UserDefaults.standard.string(forKey: "token") ?? "no token yet")
    }
}
