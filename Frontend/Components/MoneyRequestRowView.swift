//
//  MoneyRequestRowView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 29/09/22.
//

import SwiftUI

struct MoneyRequestRowView: View {
    let moneyRequest: MoneyRequest
    @EnvironmentObject var sessionState: SessionState
    
    var isSent: Bool { sessionState.user.id == moneyRequest.requesteeId }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
                .frame(width: 5)
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
        Image(isSent ? "send-money" : "receive-money")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 22, height: 22)
            .foregroundColor(Color.theme.gray500)
            .background(
                Circle()
                    .fill(
                        Color.theme.gray900
                    )
                    .frame(width: 35, height: 35)
            )
    }
    
    private struct IconLabel: View {
        let icon: String
        let text: String
        
        var body: some View {
            HStack(alignment: .center, spacing: 6) {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 12, height: 12)
                
                Text(text)
                    .font(.caption2)
                    .fontWeight(.medium)
            }
            .foregroundColor(Color.theme.white45)
        }
    }
    
    private var requestInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(moneyRequest.title)
                .font(.subheadline)
                .bold()
                .lineLimit(1)
                .foregroundColor(Color.theme.appWhite)
            
            HStack(alignment: .center, spacing: 12) {
                IconLabel(icon: "activity", text: moneyRequest.status)
                IconLabel(icon: "calendar", text: moneyRequest.createdAt.dateFromISO)
            }
        }
    }
    
    private var amount: some View {
        HStack(spacing: -1) {
            Image("rupee")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
            Text("\(moneyRequest.amount)")
                .font(.callout)
                .fontWeight(.semibold)
        }
        .foregroundColor(isSent ? Color.theme.danger : Color.theme.success)
    }
}
