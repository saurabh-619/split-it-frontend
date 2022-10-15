//
//  Bill.swift
//  Frontend
//
//  Created by Saurabh Bomble on 12/10/22.
//

import Foundation

struct Bill: Identifiable, Decodable {
    var id, version: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
    let title, description: String
    let total, totalWithoutTax, tax, paidAmount: Int
    var fractionPaid: String
    let isPaid: Bool
    let image: String?
    let leader: User
    let friends: [User]
    let billItems: [BillItem]
    let leaderId: Int
    let friendsIds, billItemIds: [Int]
}
