//
//  User.swift
//  Frontend
//
//  Created by Saurabh Bomble on 22/09/22.
//

import Foundation


protocol UserProtocol: Identifiable {
    var id: Int { get set }
    var version: Int { get set }
    var username: String { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var email: String { get set }
    var avatar: String { get set }
    var walletId: Int { get set }
    var wallet: Wallet? { get set }
    var createdAt: String { get set }
    var updatedAt: String { get set }
    var deletedAt: String? { get set }
}

struct User: UserProtocol, Identifiable, Decodable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id, version: Int
    var username, firstName, lastName, email: String
    var avatar: String
    var walletId: Int
    var wallet: Wallet?
    var createdAt, updatedAt: String
    var deletedAt: String?
}

struct UserWithoutWallet: Identifiable, Decodable {
    let id, version: Int
    let username, firstName, lastName, email: String
    let avatar: String
    let walletId: Int
    //    let wallet: Wallet?
    let createdAt, updatedAt: String
    let deletedAt: String?
}
