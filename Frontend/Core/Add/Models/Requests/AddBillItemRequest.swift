//
//  AddBillItemRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/10/22.
//

import Foundation

struct AddBillItemRequest: Encodable {
    let billId: Int
    let name: String
    let description: String
    let price: Int
    let friendIds: [Int]
    let quantity: Int
}
