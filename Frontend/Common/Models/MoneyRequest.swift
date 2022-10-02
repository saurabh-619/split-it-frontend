//
//  MoneyRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 28/09/22.
//

import Foundation

struct MoneyRequest: Identifiable, Decodable {
    var id, version: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
    let title, description: String
    let amount: Int
    let status: String
    let requesteeRemark: String?
    let requester, requestee: User?
    let requesterId, requesteeId: Int?
}
