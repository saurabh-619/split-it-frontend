//
//  SettleSplitRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/10/22.
//

import Foundation

struct SettleSplitRequest: Encodable {
    let billId, transactionId: Int
}
