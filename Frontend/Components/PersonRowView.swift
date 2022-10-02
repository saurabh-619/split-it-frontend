//
//  PersonRowView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 26/09/22.
//

import SwiftUI

struct PersonRowView: View {
    let user: User
    var hasButton = false
    var buttonText = ""
    var buttonTextColor = Color.theme.accent
    var isButtonDisabled = false
    var onButtonClicked: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 16) {
            CacheImageView(url: user.avatar) { image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: 50, height: 50)
            .clipShape(
                RoundedRectangle(cornerRadius: 20, style: .circular)
            )
            
            VStack(alignment: .leading) {
                Text("\(user.firstName) \(user.lastName)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.theme.appWhite)
                
                Text("@\(user.username)")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(Color.theme.white60)
            }
            
            if hasButton {
                Group {
                    Spacer()
                    Button {
                        onButtonClicked()
                    } label: {
                        Text(buttonText)
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(buttonTextColor)
                    }
                    .disabled(isButtonDisabled)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct PersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PersonRowView(user: self.dev.user, hasButton: true, buttonText: "add")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
