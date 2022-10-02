//
//  SheetHeadingView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 26/09/22.
//

import SwiftUI

struct SheetHeadingView: View {
    let title: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.appWhite)
                .padding(.bottom, 1)
            Spacer()
            closeButton
        }
        
    }
}

struct SheetHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeadingView(title: "edit")
    }
}

extension SheetHeadingView {
    private var closeButton: some View {
        Button {
            self.dismiss()
        } label: {
            Image("close")
                .resizable()
                .foregroundColor(Color.theme.appWhite)
                .frame(width: 18, height: 18)
        }
    }
}
