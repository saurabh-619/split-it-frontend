//
//  UpdateFriendRequestStatusRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 01/10/22.
//

import Foundation

struct UpdateFriendRequestStatusRequest: Encodable {
    let requestId: Int
    let status: String
}
