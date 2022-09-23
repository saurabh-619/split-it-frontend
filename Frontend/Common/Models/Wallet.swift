//
//  Wallet.swift
//  Frontend
//
//  Created by Saurabh Bomble on 22/09/22.
//

import Foundation

struct Wallet: Identifiable, Decodable {
    let id, version: Int
    let balance, ownerId: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
}
