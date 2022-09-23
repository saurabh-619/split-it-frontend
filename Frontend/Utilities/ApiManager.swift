//
//  ApiManager.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import Foundation

final class ApiManager {
    static let shared = ApiManager()
    
    private func getToken() -> String? {
        let tokenString = UserDefaults.standard.getToken()
        return tokenString != nil ? "Bearer \(tokenString!)" : nil
    }
    
    
    func get<T: Decodable>(_ url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.badUrl(url: url)
        }
        
        var request = URLRequest(url: url)
        request.setValue(getToken(), forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared
            .data(for: request)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let response = try decoder.decode(T.self, from: data)
        
        return response
    }
    
    func post<U: Encodable, T: Decodable>(_ url: String, body: U) async throws -> T {
        guard let body = try? JSONEncoder().encode(body) else {
            throw NetworkError.badEncode
        }
        
        guard let url = URL(string: url) else {
            throw NetworkError.badUrl(url: url)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HttpMethod.POST.rawValue
        request.setValue(getToken(), forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared
            .upload(for: request, from: body)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(T.self, from: data)
        
        return response
    }
    
    func patch<U: Encodable, T: Decodable>(_ url: String, body: U) async throws -> T {
        guard let body = try? JSONEncoder().encode(body) else {
            throw NetworkError.badEncode
        }
        
        guard let url = URL(string: url) else {
            throw NetworkError.badUrl(url: url)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HttpMethod.PATCH.rawValue
        request.setValue(getToken(), forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared
            .upload(for: request, from: body)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(T.self, from: data)
        
        return response
    }
}
