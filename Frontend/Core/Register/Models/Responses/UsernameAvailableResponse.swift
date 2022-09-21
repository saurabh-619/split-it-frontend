//
//  UsernameAvailableResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 21/09/22.
//

import Foundation

struct UsernameAvailableResponse: CoreResponse, Decodable {
    var ok: Bool
    var status: Int
    var error: String?
    let isAvailable: Bool?
}
