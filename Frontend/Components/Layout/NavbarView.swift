//
//  NavbarView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 10/10/22.
//

import SwiftUI

struct NavbarView: View {
    var title: String?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color.theme.accent)
            }
            Spacer()
            if let title = title {
                Text(title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color.theme.appWhite)
            }
            Spacer()
        }
        
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        return NavbarView(title: "yoo")
            .preferredColorScheme(.dark)
    }
}
