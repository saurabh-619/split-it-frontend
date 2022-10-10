//
//  AvatarView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 27/09/22.
//

import SwiftUI

struct AvatarView: View {
    let url: String
    var hasBorder = true
    var size = 80.0
    
    var body: some View {
        CacheImageView(url: url) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size, alignment: .center)
                .clipShape(
                    RoundedRectangle(cornerRadius: size / 3.2, style: .continuous)
                )
        }
        .padding(size / 10 )
        .backgroundColor()
        .clipShape(
            RoundedRectangle(cornerRadius: size / 2.28, style: .continuous)
        )
        .padding(size / 10)
        .background(
            hasBorder ? LinearGradient(colors: [Color.theme.accent, Color.theme.accent.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing) : nil
        )
        .clipShape(
            RoundedRectangle(cornerRadius: size / 1.78, style: .continuous)
        )
        .padding(.bottom, 5)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AvatarView(url: self.dev.user.avatar)
            AvatarView(url: self.dev.user.avatar, size: 55)
        }
        .preferredColorScheme(.dark)
    }
}
