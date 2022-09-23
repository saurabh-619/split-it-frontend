//
//  ProfileViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 22/09/22.
//

import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User = DeveloperPreview.shared.user
    @Published var toast: Toast?
    @Published var isFetching = true
    
    func getCurrentUser() async {
        do {
            let response: User = try await ApiManager.shared.get(ApiConstants.AUTH_USER_URL)
            user = response
        } catch let error {
            print(error)
            toast = Toast(type: .error, title: "ohhh oh!", message: error.localizedDescription)
        }
        isFetching = false
    }
    
    func logout() {
        UserDefaults.standard.deleteToken()
    }
}
