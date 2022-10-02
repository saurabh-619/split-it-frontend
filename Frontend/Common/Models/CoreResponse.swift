//
//  CoreResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import Foundation

protocol CoreResponse {
    var ok: Bool { get }
    var status: Int { get }
    var error: String? { get }
}

extension CoreResponse {
    var error: String? { return nil }
}

struct BaseResponse: CoreResponse, Decodable {
    var ok: Bool
    var status: Int
    var error: String?
}
