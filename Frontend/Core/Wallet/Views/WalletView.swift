//
//  WalletView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 21/09/22.
//

import SwiftUI

struct WalletView: View {
    @EnvironmentObject var sessionState: SessionState
    @StateObject var vm = WalletViewModel()
    
    @State private var selectedRequest: MoneyRequest?
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    heading
                    walletCard
                    receiveButton
                    transactionContent
                }
                .padding(.horizontal, 20)
                .frame(maxHeight: .infinity, alignment: .top)
                .task {
                    await vm.getMoneyRequests()
                }
                .onChange(of: vm.isToMeSelected) { _ in
                    Task {
                        await vm.getMoneyRequests()
                    }
                }
                .onChange(of: vm.statusChosen) { _ in
                    Task {
                        await vm.getMoneyRequests()
                    }
                }
            }
            .refreshable {
                Task {
                    await sessionState.getAuthUser()
                    await vm.getMoneyRequests()
                }
            }
            .backgroundColor()
            .toastView(toast: $vm.toast)
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension WalletView {
    private var heading: some View {
        HStack {
            Text("hello \(sessionState.user.username)")
                .font(.title2)
                .bold()
            Spacer()
            AvatarWithoutBorderView(url: sessionState.user.avatar)
        }
        .padding(.bottom, 36)
    }
    
    private var walletCard: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(
                LinearGradient(colors: [Color.theme.cardBackground.opacity(0.7), Color.theme.cardBackground.opacity(0.2)], startPoint: .topTrailing, endPoint: .bottomLeading)
            )
            .frame(height: 240)
            .frame(maxWidth: .infinity)
            .overlay {
                walletCardContent
            }
            .padding(.bottom, 16)
    }
    
    private var walletCardContent: some View {
        var walletHeading: some View {
            HStack {
                Image(systemName: "applelogo")
                    .font(.title2)
                    .foregroundColor(Color.theme.appWhite)
                Spacer()
                Text("•••• \(Int.random(in: 1000...9999).formatted(.number.grouping(.never)))")
            }
        }
        
        var walletAmount: some View {
            HStack(spacing: 1) {
                Image("rupee")
                Text((sessionState.user.wallet?.balance.getZeroDigitString)!)
                    .font(.largeTitle)
                    .bold()
            }
        }
        
        var walletFooter: some View {
            HStack {
                Text("\(sessionState.user.firstName) \(sessionState.user.lastName)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.theme.white60)
                Spacer()
                Text("#\(sessionState.user.walletId)")
                    .foregroundColor(Color.theme.white60)
            }
        }
        
        return VStack {
            walletHeading
            Spacer()
            walletAmount
            Spacer()
            walletFooter
        }
        .padding(24)
        .frame(maxHeight: 240, alignment: .top)
    }
    
    private var receiveButton: some View {
        NavigationLink {
            RequestMoneyView()
        } label: {
            VStack(spacing: 10) {
                Image("receive-money")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.theme.appWhite)
                    .frame(width: 55, height: 55)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .circular)
                            .fill(Color.theme.cardBackground)
                    )
                Text("request")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.white60)
            }
        }
        .padding(.bottom, 24)
    }
    
    private var statusDropDown: some View {
        Menu {
            ForEach(MoneyRequestStatus.allCases) { status in
                Button {
                    vm.statusChosen = status    
                } label: {
                    Text(status.rawValue)
                }
            }
        } label: {
            Text(vm.statusChosen.rawValue)
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.white80)
        }
        .menuStyle(.button)
    }
    
    private var filterSection: some View {
        HStack {
            Button {
                withAnimation(.spring()) {
                    vm.isToMeSelected = true
                }
            } label: {
                PillView(text: "to me", color: vm.isToMeSelected ? Color.theme.appWhite : Color.theme.white45, bgColor: vm.isToMeSelected ? Color.theme.accent : Color.clear)
            }
            Button {
                withAnimation(.spring()) {
                    vm.isToMeSelected = false
                }
            } label: {
                PillView(text: "by me", color: vm.isToMeSelected ? Color.theme.white45 : Color.theme.appWhite, bgColor: vm.isToMeSelected ? Color.clear : Color.theme.accent)
            }
            Spacer()
            statusDropDown
        }
    }
    
    private var transactions: some View {
        Group {
            if vm.moneyRequests.isEmpty {
                Text("no money requests yet")
                    .font(.footnote)
                    .foregroundColor(Color.theme.white60)
                    .frame(height: 90, alignment: .center)
                    .frame(maxWidth: .infinity)
            } else {
                LazyVStack {
                    ForEach(vm.moneyRequests) { request in
                        let isSent = request.requestee!.id == sessionState.user.id  
                        Button {
                            selectedRequest = request
                        } label: {
                            MoneyRequestRowView(moneyRequest: request, isWalletView: true)
                                .padding(.vertical, 10)
                        }
                        .sheet(item: $selectedRequest) { moneyRequest in
                            MoneyRequestSheetView(moneyRequest: moneyRequest, isSent: isSent, toast: $vm.toast)
                                .preferredColorScheme(.dark)
                                .presentationDetents([.fraction(0.75), .large])
                        }
                    }
                }
            }
        }
    }
    
    private var transactionContent: some View {
        VStack(alignment: .leading) {
            SectionTitleView(title: "money requests")
                .padding(.bottom, 8)
            
            filterSection
                .padding(.bottom, 8)
            
            if(vm.isLoading) {
                AccentSpinner(size: 36)
                    .frame(height: 90)
                    .frame(maxWidth: .infinity)
            } else {
                transactions
            }
        }
    }
}
