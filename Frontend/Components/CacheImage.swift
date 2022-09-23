//
//  CacheImage.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/09/22.
//

import SwiftUI

struct CacheImage<Content: View>: View {
    let url: String
    @ViewBuilder var content: (UIImage) -> Content
    
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            if imageLoader.uiImage != nil {
                content(imageLoader.uiImage!)
            } else {
                ProgressView()
            }
        }
        .task {
            await self.getImage()
        }
    }
}

extension CacheImage {
    private func getImage() async {
        do {
            try await self.imageLoader.fetchImage(URL(string: self.url))
        } catch {
            print(error.localizedDescription)
        }
    }
}
