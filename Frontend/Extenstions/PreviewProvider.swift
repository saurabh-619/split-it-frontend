//
//  PreviewProvider.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/09/22.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    private init(){}
    
    var wallet: Wallet {
        Wallet(id: 1, version: 1, balance: 5000, ownerId: 1, createdAt: "", updatedAt: "", deletedAt: "")
    }
    
    var user: User {
        User(id: 1, version: 1, username: "saurabh", firstName: "Jon", lastName: "Doe", email: "jon@gmail.com", avatar: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80", walletId: 1, wallet: self.wallet, createdAt: "", updatedAt: "", deletedAt: "")
    }
}
