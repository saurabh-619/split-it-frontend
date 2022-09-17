//
//  Request.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import Foundation

struct RegisterRequest: Encodable {
    let email: String
    let username: String
    let firstName: String
    let lastName: String
    let password: String
}
