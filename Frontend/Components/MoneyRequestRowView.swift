//
//  MoneyRequestRowView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 29/09/22.
//

import SwiftUI

struct MoneyRequestRowView: View {
    let moneyRequest: MoneyRequest
    var isWalletView: Bool = false
    
    @EnvironmentObject var sessionState: SessionState
    
    var isSent: Bool { sessionState.user.id == moneyRequest.requesteeId }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
                .frame(width: 8)
            moneyIcon
            Spacer()
                .frame(maxWidth: 20)
            requestInfo
            Spacer()
            amount
        }
    }
}

struct MoneyRequestRowView_Previews: PreviewProvider {
    static var previews: some View {
        MoneyRequestRowView(moneyRequest: self.dev.moneyRequest)
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}


extension MoneyRequestRowView {
    private var moneyIcon: some View {
        let iconSize = isWalletView ? 24.0 : 22.0
        let bgSize = isWalletView ? 40.0 : 35.0
        
        return Image(isSent ? "send-money" : "receive-money")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: iconSize, height: iconSize)
            .foregroundColor(Color.theme.gray500)
            .background(
                Circle()
                    .fill(
                        Color.theme.gray900
                    )
                    .frame(width: bgSize, height: bgSize)
            )
    }
        
    private var requestInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(moneyRequest.title)
                .font(.subheadline)
                .bold()
                .lineLimit(1)
                .foregroundColor(Color.theme.appWhite)
            if(isWalletView) {
                HStack(alignment: .center, spacing: 12) {
                    Text(isSent ? "from \(moneyRequest.requester!.username)" : "to \(moneyRequest.requestee!.username)")
                }
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.white45)
                
            } else {
                HStack(alignment: .center, spacing: 12) {
                    IconLabelView(icon: "activity", text: moneyRequest.status)
                    IconLabelView(icon: "calendar", text: moneyRequest.createdAt.dateFromISO)
                }
            }
        }
    }
    
    private var amount: some View {
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
            
            Text("\(moneyRequest.amount.withCommasString)")
                .font(.callout)
                .fontWeight(.semibold)
        }
        .foregroundColor(isSent ? Color.theme.danger : Color.theme.success)
    }
}
