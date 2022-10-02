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
    
    @Published var firstNameError: String?
    @Published var lastNameError: String?
    @Published var emailError: String?
    @Published var usernameError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    
    @Published var isUsernameAvaiable = true
    @Published var isFormDisabled = true
    
    @Published var toast: Toast?
    
    @Published var isUsernameSearching = false
    @Published var isLoading = false
    @Published var takeHome = false
    
    
    private var bag = Set<AnyCancellable>()
    
    private func validation() {
        $firstName
            .sink { [weak self] firstName in
                if(firstName.isEmpty) {
                    self?.firstNameError = "first name can't be empty"
                    self?.isFormDisabled = true
                } else {
                    self?.firstNameError = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
        
        $lastName
            .sink { [weak self] lastName in
                if(lastName.isEmpty) {
                    self?.lastNameError = "last name can't be empty"
                    self?.isFormDisabled = true
                } else {
                    self?.lastNameError = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
        
        $email
            .sink { [weak self] email in
                if(email.isEmpty) {
                    self?.emailError = "email can't be empty"
                    self?.isFormDisabled = true
                } else if(self?.isEmailValid(email: email) == false) {
                    self?.emailError = "email need to be a valid one"
                    self?.isFormDisabled = true
                } else {
                    self?.emailError = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
        
        $username
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .flatMap({[weak self] username in
                Future {promise in
                    Task {
                        if(username.isEmpty) {
                            self?.usernameError = "username can't be empty"
                            self?.isFormDisabled = true
                        } else {
                            self?.usernameError = nil
                            self?.isFormDisabled = false
                        }
                        
                        if(username.count > 2) {
                            self?.isUsernameSearching = true
                            self?.isUsernameAvaiable = await self?.checkUsernameAvailability() ?? true
                            self?.isUsernameSearching = false
                            if(self?.isUsernameAvaiable == false) {
                                self?.usernameError = "username has already been taken"
                                self?.isFormDisabled = true
                            } else {
                                self?.usernameError = nil
                                self?.isFormDisabled = false
                            }
                        }
                    }
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .assign(to: &$username)
        
        $password
            .sink { [weak self] password in
                if(password.isEmpty) {
                    self?.passwordError = "password can't be empty"
                    self?.isFormDisabled = true
                } else if(password.count < 3){
                    self?.passwordError = "password is too short"
                    self?.isFormDisabled = true
                } else if(password.count > 30){
                    self?.passwordError = "password is too long"
                    self?.isFormDisabled = true
                } else {
                    self?.passwordError = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
        
        $confirmPassword
            .sink { [weak self] confirmPassword in
                if(self?.password.isEmpty == false) {
                    if(confirmPassword != self?.password) {
                        self?.confirmPasswordError = "confirm password doesn't match password"
                        self?.isFormDisabled = true
                    } else {
                        self?.confirmPasswordError = nil
                        self?.isFormDisabled = false
                    }
                }
            }
            .store(in: &bag)
    }
    
    private func isEmailValid(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    private func checkUsernameAvailability() async -> Bool {
        do {
            let response: UsernameAvailableResponse = try await ApiManager.shared.get("\(ApiConstants.USERNAME_AVAILABLE_URL)=\(username)")
            print(response)
            if(response.ok) {
                return response.isAvailable!
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch let error {
            print(error)
            toast = Toast(type: .error, title: "error", message: error.localizedDescription)
            return false
        }
    }
    
    func register() async -> Bool {
        validation()
        
        if(isFormDisabled) { return false }
        
        let registerRequest = RegisterRequest(email: email, username: username, firstName: firstName, lastName: lastName, password: password)
        
        isLoading = true
        do {
            let response: RegisterResponse = try await ApiManager.shared
                .post(ApiConstants.REGISTER_URL, body: registerRequest)
            if(response.ok) {
                UserDefaults.standard.setToken(response.token!)
                toast = Toast(type: .success, title: "congratulations!", message: "hello \(firstName)😀, welcome to splitit app")
                try await Task.sleep(nanoseconds: 1_000_000_000)
                return true
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch let error {
            toast = Toast(type: .error, title: "error", message: error.localizedDescription)
            return false
        }
    }
}
