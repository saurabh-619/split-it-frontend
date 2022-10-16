//
//  TransactionDetailsSheetView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/10/22.
//

import SwiftUI

struct TransactionDetailsSheetView: View {
    var transaction: Transaction
    
    var body: some View {
        Text(transaction.bill?.title ?? "")
    }
}

struct TransactionDetailsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsSheetView(transaction: self.dev.transaction)
            .preferredColorScheme(.dark)
    }
}
