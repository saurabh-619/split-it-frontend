//
//  Errors.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case badEncode
    case badUrl(url: String)
    case badResponse
    case badData
    case failedToDecode
    case backendError(_ errorMsg: String)
    case custom(_: Error)
    
    var errorDescription: String? {
        switch self {
        case .badEncode:
            return "couldn't encode the request object"
        case .badUrl(let url):
            return "couldn't retrieve the url - \(url)"
        case .badResponse:
            return "couldn't complete the request. got bad response from api"
        case .badData:
            return "couldn't get the data. bad data recieved"
        case .failedToDecode:
            return "couldn't decode the data"
        case .backendError(let errorMsg):
            return errorMsg
        case .custom(let error):
            return error.localizedDescription
        }
    }
}

enum NetworkImageError: Error {
    case badRequest
    case badUrl
    case unsupportedImage
}
