//
//  LoginViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    
    @Published var usernameErrorMsg: String?
    @Published var passwordErrorMsg: String?
    
    @Published var isPasswordVisible = false
    @Published var isLoading = false
    
    @Published var isFormDisabled = true
    @Published var toast: Toast?
    @Published var takeHome = false
    
    private var bag = Set<AnyCancellable>()
    
    private func resetErrors() {
        usernameErrorMsg = nil
        passwordErrorMsg = nil
    }
    
    private func validation() {
        $username
            .sink { [weak self] username in
                if(username.isEmpty) {
                    self?.usernameErrorMsg =  "username can't be empty"
                    self?.isFormDisabled = true
                } else {
                    self?.usernameErrorMsg = nil
                    self?.isFormDisabled = false
                } 
            }
            .store(in: &bag)
        
        $password
            .sink { [weak self] password in
                if(password.isEmpty == true) {
                    self?.passwordErrorMsg = "password can't be empty"
                    self?.isFormDisabled = true
                } else {
                    self?.passwordErrorMsg = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
    }
    
    func login() async {
        validation()
        if(isFormDisabled) { return }
        
        let loginRequest = LoginRequest(username: username, password: password)
        
        guard let body = try? JSONEncoder().encode(loginRequest) else {
            debugPrint("couldn't encode the request object")
            return
        }
        
        guard let url = ApiConstants.loginUrl else {
            debugPrint("couldn't get the url")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: body)
            let response = try JSONDecoder().decode(LoginResponse.self, from: data)
            if(response.ok) {
                UserDefaults.standard.setValue(response.token!, forKey: "token")
                toast = Toast(type: .success, title: "congratulations!", message: "welcome back to splitit app")
                
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                takeHome = true
            } else {
                toast = Toast(type: .error, title: "error", message: response.error ?? "")
            }
        } catch  {
            debugPrint("couldnt make login request.")
            debugPrint(error.localizedDescription)
        }
    }
}
