//
//  PillView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 03/10/22.
//

import SwiftUI

struct PillView: View {
    var text = "pill"
    var color = Color.theme.appWhite
    var bgColor = Color.theme.accent
    
    var body: some View {
        Text(text)
            .padding(.vertical, 5)
            .padding(.horizontal, 16)
            .font(.callout)
            .foregroundColor(color)
            .background(bgColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 500, style: .circular)
            )
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView()
            .preferredColorScheme(.dark)
    }
}
