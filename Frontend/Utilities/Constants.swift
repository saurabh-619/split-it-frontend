//
//  Constants.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import Foundation

struct ApiConstants {
    static let LOGIN_URL = "http://localhost:3000/auth/login"
    static let REGISTER_URL = "http://localhost:3000/auth/register"
    static let USERNAME_AVAILABLE = "http://localhost:3000/user/is-available?username"
}

struct AppStorageKeys {
    static let TOKEN = "token"
}

enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case PUT = "PUT"
    case DELETE = "DELETE"
}
