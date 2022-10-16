//
//  CacheImageView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/09/22.
//

import SwiftUI

struct CacheImageView<Content: View>: View {
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

struct CacheImageView_Previews: PreviewProvider {
    static var previews: some View {
        CacheImageView(url: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2960&q=80", content: { uiImage in
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
        })
            .preferredColorScheme(.dark)
    }
}


extension CacheImageView {
    private func getImage() async {
        do {
            try await self.imageLoader.fetchImage(URL(string: self.url))
        } catch {
            print(error.localizedDescription)
        }
    }
}
