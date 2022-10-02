//
//  AvatarWithoutBorder.swift
//  Frontend
//
//  Created by Saurabh Bomble on 02/10/22.
//

import SwiftUI

struct AvatarWithoutBorder: View {
    let url: String
    var size = 50.0
    var cornerRadius = 19.0
    var contentMode: ContentMode = .fill
    
    var body: some View {
        CacheImageView(url: url) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width: size, height: size)
                .clipShape(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                )
        }
    }
}

struct AvatarWithoutBorder_Previews: PreviewProvider {
    static var previews: some View {
        AvatarWithoutBorder(url: self.dev.user.avatar)
            .preferredColorScheme(.dark)
    }
}
