//
//  Bill.swift
//  Frontend
//
//  Created by Saurabh Bomble on 12/10/22.
//

import Foundation

struct PaymentInfo: Decodable {
    let hasPaid: Bool
    let amount: Int
}

struct UserWithPaymentInfo: UserProtocol, Identifiable, Decodable, Equatable {
    static func == (lhs: UserWithPaymentInfo, rhs: UserWithPaymentInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id, version: Int
    var username, firstName, lastName, email: String
    var avatar: String
    var walletId: Int
    var wallet: Wallet?
    var createdAt, updatedAt: String
    var deletedAt: String?
    var paymentInfo: PaymentInfo
}

struct Bill: Identifiable, Decodable {
    var id, version: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
    let title, description: String
    let total, totalWithoutTax, tax, paidAmount: Int
    var fractionPaid: String
    let isPaid: Bool
    let image: String?
    let leader: UserWithPaymentInfo?
    let friends: [UserWithPaymentInfo]?
    let billItems: [BillItem]?
    let leaderId: Int
    let friendsIds, billItemIds: [Int]
}
