//
//  AvatarView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 27/09/22.
//

import SwiftUI

struct AvatarView: View {
    let url: String
    var body: some View {
        CacheImageView(url: url) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                )
        }
        .padding(8)
        .backgroundColor()
        .clipShape(
            RoundedRectangle(cornerRadius: 35, style: .continuous)
        )
        .padding(8)
        .background(
            LinearGradient(colors: [Color.theme.accent, Color.theme.accent.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 45, style: .continuous)
        )
        .padding(.bottom, 5)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: self.dev.user.avatar)
            .preferredColorScheme(.dark)
    }
}
