//
//  LoginResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import Foundation

struct LoginResponse: CoreResponse, Decodable {    
    var ok: Bool
    var status: Int
    var error: String?
    let token: String?
}
