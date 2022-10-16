//
//  GetTransactionsResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/10/22.
//

import Foundation

struct GetTransactionsResponse: CoreResponse, Decodable {
    let ok: Bool
    let status: Int
    let error: String?
    let transactions: [Transaction]
}
