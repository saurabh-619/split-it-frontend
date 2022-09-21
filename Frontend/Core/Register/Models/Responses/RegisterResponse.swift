//
//  Response.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import Foundation

struct RegisterResponse: CoreResponse ,Decodable {
    let ok: Bool
    let status: Int
    let error: String?
    let token: String?
}
