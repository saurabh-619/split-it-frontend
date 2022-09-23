//
//  EditProfileResponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/09/22.
//

import Foundation

struct EditProfileResponse: CoreResponse, Decodable {
    let ok: Bool
    let status: Int
}
