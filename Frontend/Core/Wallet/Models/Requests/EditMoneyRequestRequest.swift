//
//  EditMoneyRequestRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 09/10/22.
//

import Foundation

struct EditMoneyRequestRequest: Encodable {
    let title: String
    let description: String
    let amount: Int
    let requestId: Int
    let transactionId: Int
}
