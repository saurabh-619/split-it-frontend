//
//  AvatarRowView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 13/10/22.
//

import SwiftUI

struct AvatarRowView: View {
    let people: [User]
    var size: Double = 45.0
    var radius: Double = 45.0
    var offset: Double = 3.0
    var hasBorder: Bool = true
    
    var body: some View {
        let bound = people.count > 3 ? 3 : people.count - 1
        return ZStack {
            ForEach(people.indices[0...bound], id: \.self) { index in
                CacheImageView(url: people[index].avatar) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .cornerRadius(radius)
                        .padding(size/11.3)
                        .background(Color.theme.appWhite)
                        .cornerRadius(radius)
                        .offset(x: Double(index) * (size - offset))
                }
            }
            if people.count > 4 {
                Text("\(people.count-4)+")
                    .font(.caption2)
                    .bold()
                    .foregroundColor(Color.theme.white60)
                    .frame(width: size, height: size)
                    .padding(size/11.3)
                    .background(Color.theme.cardBackground)
                    .cornerRadius(radius)
                    .offset(x: Double(4) * (size - offset))
            }
        }
//        .frame(maxWidth: .infinity, alignment: .leading) 
    }
}

struct AvatarRowView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarRowView(people: self.dev.friends)
            .preferredColorScheme(.dark)
    }
}
