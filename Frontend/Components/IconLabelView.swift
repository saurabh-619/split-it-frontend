//
//  IconLabelView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 05/10/22.
//

import SwiftUI

struct IconLabelView: View {
    let icon: String
    let text: String
    
    var color = Color.theme.white45
    var iconSize = 12.0
    var font: Font = .caption2
    var spacing = 6.0
    
    var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: iconSize, height: iconSize)
            
            Text(text)
                .font(font)
                .fontWeight(.medium)
        }
        .foregroundColor(color)
    }
}

struct IconLabe_Previews: PreviewProvider {
    static var previews: some View {
        IconLabelView(icon: "calendar", text: self.dev.moneyRequest.createdAt.dateFromISO)
            .preferredColorScheme(.dark)
    }
}
