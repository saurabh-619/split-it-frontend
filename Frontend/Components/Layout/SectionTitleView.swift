//
//  SectionTitle.swift
//  Frontend
//
//  Created by Saurabh Bomble on 03/10/22.
//

import SwiftUI

struct SectionTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.appWhite)
    }
}

struct SectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleView(title: "near by friends")
            .preferredColorScheme(.dark)
    }
}
