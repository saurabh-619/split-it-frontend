//
//  RegisterViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import SwiftUI
import Combine

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isPasswordVisible = false
    
    @Published var firstNameError: String = ""
    @Published var lastNameError: String = ""
    @Published var emailError: String = ""
    @Published var usernameError: String = ""
    @Published var passwordError: String = ""
    @Published var confirmPasswordError: String = ""
    
    @Published var isFormDisabled = true
    @Published var takeHome = false
    @Published var toast: Toast?
    
    func validation() {
        
    }
    
    func register() async {
        validation()
        
//        if(isFormDisabled) { return }
        
        let registerRequest = RegisterRequest(email: email, username: username, firstName: firstName, lastName: lastName, password: password)
        
        guard let body = try? JSONEncoder().encode(registerRequest) else {
            debugPrint("couldn't encode the request object")
            return
        }
        
        guard let url = ApiConstants.registerUrl else {
            debugPrint("couldn't get the url")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: body)
            let response = try JSONDecoder().decode(RegisterResponse.self, from: data)
            
            if(response.ok) {
                UserDefaults.standard.setValue(response.token!, forKey: "token")
                toast = Toast(type: .success, title: "congratulations!", message: "welcome to splitit app")
                
                try await Task.sleep(1_000_000_000)
                takeHome = true 
            } else {
                toast = Toast(type: .error, title: "error", message: response.error ?? "")
            }
        } catch {
            debugPrint("couldn't complete register request")
            debugPrint(error.localizedDescription)
        }
        
    }
}
