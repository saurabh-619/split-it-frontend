//
//  EditProfileViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/09/22.
//

import Foundation
import Combine

@MainActor
class EditProfileViewModel: ObservableObject {
    let user: User
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var username: String = ""
    
    @Published var firstNameError: String?
    @Published var lastNameError: String?
    @Published var emailError: String?
    @Published var usernameError: String?
    
    @Published var isUsernameAvaiable = true
    @Published var isFormDisabled = true
    
    @Published var toast: Toast?
    
    @Published var isUsernameSearching = false
    @Published var isLoading = false
    
    private var bag = Set<AnyCancellable>()
    
    init(user: User) {
        self.user = user
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.username = user.username
        self.email = user.email
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
                        
                        if(username.count > 2 && username != self?.user.username) {
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
    
    func edit(dismiss: () -> Void) async {
        validation()
        if(isFormDisabled) { return }
        
        let editRequest = EditProfileRequest(username: username, firstName: firstName, lastName: lastName, email: email)
        isLoading = true
        
        do {
            let response: EditProfileResponse = try await ApiManager.shared
                .patch(ApiConstants.EDIT_PROFILE_URL, body: editRequest)
            if(response.ok) {
                toast = Toast(type: .success, title: "congratulations!", message: "hi \(firstName)😀, your profile was updated successfully")
                try await Task.sleep(nanoseconds: 1_000_000_000)
                dismiss()
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch let error {
            toast = Toast(type: .error, title: "error", message: error.localizedDescription)
        }
        isLoading = false
    }
}
