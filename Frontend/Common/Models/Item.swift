//
//  Item.swift
//  Frontend
//
//  Created by Saurabh Bomble on 12/10/22.
//

import Foundation

struct Item: Decodable {
    let id, version: Int
    let createdAt, updatedAt: String
    let deletedAt: String?
    let name, description: String
    let price: Int
    let image: String?
}
