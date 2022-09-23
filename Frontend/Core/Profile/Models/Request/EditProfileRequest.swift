//
//  EditRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/09/22.
//

import Foundation

struct EditProfileRequest: Encodable {
    let username: String
    let firstName: String
    let lastName: String
    let email: String
}
