//
//  BasicInfoResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/10/22.
//

import Foundation

struct BasicInfoResponse: CoreResponse, Decodable {
    let ok: Bool
    let status: Int
    let error: String?
    let billId: Int
}
