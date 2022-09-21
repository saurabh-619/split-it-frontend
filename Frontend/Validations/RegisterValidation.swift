//
//  LoginValidation.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/09/22.
//

import SwiftUI
import Combine

class RegisterValidation {
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var username: String
    @Published var password: String
    @Published var confirmPassword: String
    @Published var isFormDisabled: Bool
    
    var firstNameError: String?
    var lastNameError: String?
    var emailError: String?
    var usernameError: String?
    var passwordError: String?
    var confirmPasswordError: String?
    
    init(firstName: String, lastName: String, email: String, username: String, password: String, confirmPassword: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
    }

    private var bag = Set<AnyCancellable>()

    func isEmailValid(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
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
            .sink { [weak self] username in
                if(username.isEmpty) {
                    self?.usernameError = "username can't be empty"
                    self?.isFormDisabled = true
                } else {
                    self?.usernameError = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
        
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
    
}
