//
//  BillItem.swift
//  Frontend
//
//  Created by Saurabh Bomble on 12/10/22.
//

import Foundation

struct BillItem: Identifiable, Decodable {
    var id, version: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
    let quantity, total: Int
    let friends: [User]
    let item: Item
    let billId: Int
}
