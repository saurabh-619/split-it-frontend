//
//  AddFriendsRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/10/22.
//

import Foundation

struct AddFriendsRequest: Encodable {
    let billId: Int
    let friendIds: [Int]
}
