//
//  PriceView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/10/22.
//

import SwiftUI

struct PriceView: View {
    var price: Int
    var fontSize: Double = 16
    var color: Color = Color.theme.appWhite
    var fontWeight: Font.Weight = .regular
    
    var body: some View {
        HStack(spacing: 0) {
            Image("rupee")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: fontSize, height: fontSize)
            Text(price.withCommasString)
                .font(.system(size: fontSize))
                .fontWeight(fontWeight)
        }
        .foregroundColor(color)
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(price: 350)
            .preferredColorScheme(.dark)
    }
}
