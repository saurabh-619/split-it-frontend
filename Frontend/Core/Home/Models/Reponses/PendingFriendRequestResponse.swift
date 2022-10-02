//
//  PendingRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/09/22.
//

import Foundation

struct PendingFriendRequestResponse: CoreResponse, Decodable {
    let status: Int
    let ok: Bool
    let error: String?
    let count: Int?
    let friendRequests: [FriendRequest]?
}
