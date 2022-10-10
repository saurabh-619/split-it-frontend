//
//  MoneyRequestsResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 03/10/22.
//

import Foundation

struct MoneyRequestsResponse: CoreResponse, Decodable {
    let ok: Bool
    let status: Int
    let error: String?
    let moneyRequests: [MoneyRequest]
}

