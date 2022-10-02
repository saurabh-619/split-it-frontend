//
//  SearchUsersResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 26/09/22.
//

import Foundation

struct SearchUsersResponse: CoreResponse, Decodable {
    let status: Int
    let ok: Bool
    let error: String?
    let size: Int?
    let results: [User]?
}
