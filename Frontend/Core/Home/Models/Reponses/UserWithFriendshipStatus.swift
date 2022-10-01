//
//  UserWithFriendshipStatus.swift
//  Frontend
//
//  Created by Saurabh Bomble on 27/09/22.
//

import Foundation

struct UserWithFriendshipStatus: CoreResponse, Decodable {
    let ok: Bool
    let status: Int
    let error: String?
    let friendRequestId: Int?
    let isFriend: Bool
    let friendshipStatus: String?
    let user: User
    let moneyRequests: [MoneyRequest]
}
