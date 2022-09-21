//
//  NetworkManager.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Decodable>(_ url: String, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            return completionHandler(.failure(NetworkError.badUrl(url: url)))
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            DispatchQueue.main.async {
                self?.taskHandler(data: data, response: response, error: error, completionHandler: completionHandler)
            }
        }
        
        dataTask.resume()
    }
    
    func post<T: Decodable>(_ url: String, body: Data, responseType: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            return completionHandler(.failure(NetworkError.badUrl(url: url)))
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HttpMethod.POST.rawValue
        
        let dataTask = URLSession.shared.uploadTask(with: request, from: body) {[weak self] data, response, error in
            DispatchQueue.main.async {
                self?.taskHandler(data: data, response: response, error: error, completionHandler: completionHandler)
            }
        }
        dataTask.resume()
    }
    
    // MARK: private
    private func taskHandler<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        if let error {
            return completionHandler(.failure(NetworkError.custom(error)))
        }
        
        guard let data = data else {
            return completionHandler(.failure(NetworkError.badData))
        } 
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(T.self, from: data)
            
            completionHandler(.success(response))
        } catch  {
            completionHandler(.failure(NetworkError.failedToDecode))
        }
    }
}

