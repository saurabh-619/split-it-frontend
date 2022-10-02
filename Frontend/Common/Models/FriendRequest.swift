//
//  FriendRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/09/22.
//

import Foundation

struct FriendRequest: Identifiable, Decodable {
    let id, version: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
    let status: String
    let requester, requestee: User
    let requesterId, requesteeId: Int
}

struct FriendRequestWithRequester: Identifiable {
    let id: Int
    let requester: User
}
