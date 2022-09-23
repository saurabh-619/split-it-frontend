//
//  AuthUserResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 22/09/22.
//

import Foundation

struct AuthUserResponse: Decodable {
    let id, version: Int
    let username, firstName, lastName, email: String
    let avatar: String
    let walletId: Int
    let wallet: Wallet
    let createdAt, updatedAt: String
    let deletedAt: String?
}
