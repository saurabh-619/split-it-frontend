//
//  Transaction.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/10/22.
//

import Foundation

struct Transaction: Decodable, Identifiable {
    var id, version: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
    let amount: Int
    let type: TransactionType.RawValue
    let isComplete: Bool
    let from: User
    let to: User?
    let billId, moneyRequestId: Int?
    let bill: Bill?
    let moneyRequest: MoneyRequest?
    let fromId: Int
    let toId: Int?
}
