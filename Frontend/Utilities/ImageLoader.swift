//
//  ImageLoader.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/09/22.
//

import SwiftUI

@MainActor
class ImageLoader: ObservableObject {
    @Published var uiImage: UIImage?
    private static let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(_ url: URL?) async throws {
        guard let url else {
            throw NetworkImageError.badUrl
        }
        
        // check in cache
        if let cachedImage = Self.cache.object(forKey: url.absoluteString as NSString) {
            uiImage = cachedImage
            return
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
            throw NetworkImageError.badRequest
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkImageError.unsupportedImage
        }
        
        // store it in cache
        Self.cache.setObject(image, forKey: url.absoluteString as NSString)
        uiImage = image
    }
}
 
