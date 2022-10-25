//
//  TransactionsView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/10/22.
//

import SwiftUI

struct TransactionsView: View {
    @EnvironmentObject var sessionState: SessionState
    @StateObject var vm = TransactionsViewModel()
    
    @State var selectedTransaction: Transaction?
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    heading
                    filterSection
                    transactionContent
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .backgroundColor()
                .toastView(toast: $vm.toast)
                .task {
                    await vm.getTransactions()
                }
                .onChange(of: vm.type) { _ in
                    Task {
                        await vm.getTransactions()
                    }
                }
                .onChange(of: vm.state) { _ in
                    Task {
                        await vm.getTransactions()
                    }
                }
            }
            .refreshable {
                Task {
                    await vm.getTransactions()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension TransactionsView {
    private var heading: some View {
        NavbarView(title: "transactions")
            .padding(.bottom, 25)
    }
    
    @ViewBuilder
    private func PillButtonView(text: String, type: TransactionType) -> some View {
        Button {
            withAnimation(.spring()) {
                vm.type = type
            }
        } label: {
            PillView(text: text, color: vm.type == type ? Color.theme.appWhite : Color.theme.white45, bgColor: vm.type == type ? Color.theme.accent : Color.clear)
        }
    }
    
    private var statusDropDown: some View {
        Menu {
            ForEach(TransactionState.allCases) { state in
                Button {
                    vm.state = state
                } label: {
                    Text(state.rawValue)
                }
            }
        } label: {
            Text(vm.state.rawValue)
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.white80)
        }
        .menuStyle(.button)
    }
    
    private var filterSection: some View {
        HStack {
            ForEach(TransactionType.allCases) { type in
                PillButtonView(text: type.rawValue, type: type)
            }
            Spacer()
            statusDropDown
        }
        .padding(.bottom, 16)
    }
    
    private func isSentTransaction(transaction: Transaction) -> Bool {
        if(transaction.type == "bill") {
            return true
        }
        return transaction.from.id == sessionState.user.id
    }
    
    @ViewBuilder
    private func AmountView(isSent: Bool, amount: Int) -> some View {
        HStack(spacing: 0) {
            if(isSent) {
                Text("-")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.trailing, 8)
            }
            Image("rupee")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .padding(.horizontal, -4)
            
            Text("\(amount.withCommasString)")
                .font(.callout)
                .fontWeight(.semibold)
        }
        .foregroundColor(isSent ? Color.theme.danger : Color.theme.success)
    }
    
    @ViewBuilder
    private func TransactionRowView(transaction: Transaction) -> some View {
        let isSent = isSentTransaction(transaction: transaction)
        let isBill = transaction.billId != nil
        
        VStack {
            HStack {
                AvatarView(url: isSent ? (transaction.to?.avatar ?? "") : transaction.from.avatar, hasBorder: false, size: 42)
                VStack(alignment: .leading, spacing: 8) {
                    Text((isBill ? transaction.bill?.title : transaction.moneyRequest?.title) ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.theme.appWhite)
                        .lineLimit(1)
                    IconLabelView(icon: "calendar", text: transaction.createdAt.dateFromISOMonth)
                        .font(.caption)
                        .foregroundColor(Color.theme.white60)
                }
                Spacer()
                AmountView(isSent: isSent, amount: transaction.amount)
                    .frame(minWidth: 70, alignment: .trailing)
            }
            .padding(.vertical, 4)
            Divider()
                .frame(maxWidth: .infinity)
                .overlay(Color.theme.gray500)
        }
    }
    
    private var transactions: some View {
        LazyVStack(alignment: .leading) {
            ForEach(vm.transactions) { transaction in
                Button {
                    selectedTransaction = transaction
                } label: {
                    TransactionRowView(transaction: transaction)
                }
            }
        }
        .sheet(item: $selectedTransaction) { transaction in
            TransactionDetailsSheetView(transaction: transaction, isSent: isSentTransaction(transaction: transaction), toast: $vm.toast)
        }
    }
    
    private var transactionContent: some View {
        Group {
            if vm.isLoading {
                AccentSpinner()
                    .frame(height: 450)
                    .frame(maxWidth: .infinity)
            } else {
                if vm.transactions.isEmpty {
                    Text("no \(vm.state.rawValue) \(vm.type.rawValue) transactions generated yet")
                        .font(.footnote)
                        .foregroundColor(Color.theme.white60)
                        .frame(height: 450, alignment: .center)
                        .frame(maxWidth: .infinity)
                } else {
                    transactions
                }
            }
        }
    }
}
