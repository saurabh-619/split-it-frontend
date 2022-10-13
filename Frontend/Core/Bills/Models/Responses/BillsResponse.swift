//
//  BillsResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 12/10/22.
//

import Foundation

struct BillsResponse: CoreResponse, Decodable {
    let ok: Bool
    let status: Int
    let error: String?
    let size: Int
    let hasLeft: Bool
    let bills: [Bill]
}
