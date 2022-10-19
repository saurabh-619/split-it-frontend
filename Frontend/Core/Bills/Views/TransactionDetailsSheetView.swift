//
//  TransactionDetailsSheetView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/10/22.
//

import SwiftUI

struct TransactionDetailsSheetView: View {
    let transaction: Transaction
    let isSent: Bool
    
    @StateObject var vm: TransactionDetailsSheetViewModel
    @EnvironmentObject var sessionState: SessionState
    @Environment(\.dismiss) var dismiss
    
    
    init(transaction: Transaction, isSent: Bool, toast: Binding<Toast?>) {
        self.transaction = transaction
        self.isSent = isSent
        self._vm = StateObject(wrappedValue: TransactionDetailsSheetViewModel(toast: toast))
    }
    
    var body: some View {
        VStack {
            heading
            transactionContent
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .backgroundColor()
    }
}

struct TransactionDetailsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsSheetView(transaction: self.dev.transaction2, isSent: true, toast: .constant(Toast(title: "", message: "")))
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension TransactionDetailsSheetView {
    private var toFromUser: User? {
        if(transaction.type == "bill") {
            return nil
        }
        return isSent ? transaction.to : transaction.from
    }
    
    private var infoIdTitle: String {
        transaction.type == "wallet" ? "money transfer" : "bill"
    }
    
    private var infoId: Int {
        transaction.type == "wallet" ? transaction.moneyRequestId! : transaction.billId!
    }
    
    private var heading: some View {
        SheetHeadingView(title: "transaction details")
            .padding(.bottom, 48)
    }
    
    @ViewBuilder
    private func ToFromDataView(user: User?) -> some View {
        if let user {
            VStack(spacing: 0) {
                CacheImageView(url: user.avatar) { uiImage in
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 35, style: .continuous)
                        )
                }
                .padding(.bottom, 16)
                
                Text("\(user.firstName) \(user.lastName)")
                    .font(.title3)
                    .foregroundColor(Color.theme.appWhite)
                    .bold()
                    .padding(.bottom, 8)
                
                IconLabelView(icon: "calendar", text: transaction.createdAt.dateFromISO)
                    .font(.subheadline)
                    .foregroundColor(Color.theme.white45)
            }
            .padding(.bottom, 45)
        }
    }
    
    private var price: some View {
        HStack(alignment: .bottom, spacing: 4) {
            if isSent {
                Text("-")
                    .font(.system(size: 40))
                    .bold()
            }
            Text(transaction.amount.withCommasString)
                .font(.system(size: 40))
                .bold()
                .padding(.trailing, 4)
            
            Text("rupees")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.white60)
                .padding(.bottom, 7)
        }
        .foregroundColor(Color.theme.appWhite)
        .padding(.vertical, 20)
    }
    
    private var divider: some View {
        Divider()
            .background(Color.theme.gray400)
    }
    
    @ViewBuilder
    private func DetailRow(title: String, value: String, color: Color = Color.theme.white60) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(color)
        }
        .font(.subheadline)
        .foregroundColor(Color.theme.white60)
    }
    
    @ViewBuilder
    private func BillMoneyRequestDetailsView() -> some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitleView(title: "\(infoIdTitle) details")
                .padding(.bottom, 8)
            DetailRow(title: "id", value: "#\(infoId)")
            DetailRow(title: "status", value: "\(transaction.isComplete ? "PAID" : "PENDING")", color: transaction.isComplete ? Color.theme.success : Color.theme.danger)
            DetailRow(title: "type of transaction", value: "\(transaction.type)")
        }
    }
    
    
    private var action: some View {
        ActionButtonView(text: "settle split") {
            Task {
                await vm.settleSplit(billId: transaction.billId!, transactionId: transaction.id) {
                    dismiss()
                }
                await sessionState.getAuthUser()
            }
        }
    }
    
    private var transactionContent: some View {
        VStack {
            ToFromDataView(user: toFromUser)
            divider
            price
            divider
                .padding(.bottom, 25)
            BillMoneyRequestDetailsView()
            Spacer()
            if transaction.type == "split" {
                action
            }
        }
    }
}
