//
//  Constants.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import Foundation

struct ApiConstants {
    // login and register
    static let LOGIN_URL = "http://localhost:3000/auth/login"
    static let REGISTER_URL = "http://localhost:3000/auth/register"
    static let USERNAME_AVAILABLE_URL = "http://localhost:3000/user/is-available?username"
    
    // profile
    static let AUTH_USER_URL = "http://localhost:3000/auth"
    static let EDIT_PROFILE_URL = "http://localhost:3000/user"
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
