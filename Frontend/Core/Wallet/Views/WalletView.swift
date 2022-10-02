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
    
    var body: some View {
        VStack {
            heading
            walletCard
        }
        .padding(20)
        .frame(maxHeight: .infinity, alignment: .top)
        .backgroundColor()
        .toastView(toast: $vm.toast)
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
            AvatarWithoutBorder(url: sessionState.user.avatar)
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
}
