//
//  DropDownView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/10/22.
//

import SwiftUI

struct DropDownView<T: MoneyRequestStatus>: View {
    @Binding var choosenBinding: T
    
    var body: some View {
        Menu {
            ForEach(T.allCases, id: \.self) { item in
                Button {
                    choosenBinding = item
                } label: {
                    Text(choosenBinding.rawValue)
                }
            }
        } label: {
            Text(choosenBinding)
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.white80)
        }
        .menuStyle(.button)
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView<TransactionType>(choosenBinding: .constant(.BILL))
            .preferredColorScheme(.dark)
    }
}
