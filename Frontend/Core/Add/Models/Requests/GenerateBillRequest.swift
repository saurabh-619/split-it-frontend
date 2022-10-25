//
//  GenerateBillRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/10/22.
//

import Foundation

struct Split: Encodable {
    let friendId: Int
    let split: Int?
}

struct GenerateBillRequest: Encodable {
    let billId: Int
    let tax: Int
    let isPaid: Bool
    let isEqualSplit: Bool
    let splits: [Split]
}

