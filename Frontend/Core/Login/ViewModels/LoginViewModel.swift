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
    
    func login() async -> Bool {
        validation()
        
        if(isFormDisabled) { return false }
        
        let loginRequest = LoginRequest(username: username, password: password)
        
        isLoading = true
        do {
            let response: LoginResponse = try await ApiManager.shared
                .post(ApiConstants.LOGIN_URL, body: loginRequest)
            
            if(response.ok) {
                UserDefaults.standard.setToken(response.token!)
                toast = Toast(type: .success, title: "congratulations!", message: "hi again \(username)😀, welcome back to splitit app")
                return true
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch let error {
            toast = Toast(type: .error, title: "error", message: error.localizedDescription)
            isLoading = false
            return false
        }
    }
}
