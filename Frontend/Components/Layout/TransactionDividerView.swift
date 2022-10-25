//
//  TransactionDividerView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/10/22.
//

import SwiftUI

struct TransactionDividerView: View {
    var isDashed: Bool = true
    
    var body: some View {
        Rectangle()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: isDashed ? [9] : [], dashPhase: 14))
            .frame(maxWidth: .infinity, maxHeight: 0.5)
            .foregroundColor(Color.theme.gray800)
    }
}

struct TransactionDividerView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDividerView()
    }
}
