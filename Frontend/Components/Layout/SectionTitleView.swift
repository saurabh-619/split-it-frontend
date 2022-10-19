//
//  SectionTitle.swift
//  Frontend
//
//  Created by Saurabh Bomble on 03/10/22.
//

import SwiftUI

struct SectionTitleView: View {
    let title: String
    var color: Color = Color.theme.appWhite
    var fontWeight: Font.Weight = Font.Weight.bold
    
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(fontWeight)
            .foregroundColor(color)
    }
}

struct SectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleView(title: "near by friends")
            .preferredColorScheme(.dark)
    }
}
