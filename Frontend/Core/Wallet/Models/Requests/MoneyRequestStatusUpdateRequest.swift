//
//  MoneyRequestStatusUpdateRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 07/10/22.
//

import Foundation

struct MoneyRequestStatusUpdateRequest: Encodable {
    let requestId: Int
    let transactionId: Int
    let status: MoneyRequestStatus.RawValue
    let requesteeRemark: String?
}
