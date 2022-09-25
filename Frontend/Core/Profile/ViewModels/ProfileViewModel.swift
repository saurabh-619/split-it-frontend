//
//  ProfileViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 22/09/22.
//

import SwiftUI
import CoreData

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var showEdit = false
    
    func logout() {
        UserDefaults.standard.deleteToken()
    }
}
