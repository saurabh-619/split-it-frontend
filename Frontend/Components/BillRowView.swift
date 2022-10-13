//
//  BillRowView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 12/10/22.
//

import SwiftUI

struct BillRowView: View {
    let isLeader: Bool
    let bill: Bill
    
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            icon
            billInfo
            Spacer()
            progress
        }
        .frame(maxWidth: .infinity)
    }
}

struct BillRowView_Previews: PreviewProvider {
    static var previews: some View {
        BillRowView(isLeader: true,bill: self.dev.bill)
            .preferredColorScheme(.dark)
    }
}


extension BillRowView {
    private var icon: some View {
        Image(isLeader ? "receive-money" : "send-money")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 32, height: 32)
            .foregroundColor(isLeader ? Color.theme.success : Color.theme.danger)
            .frame(width: 65, height: 65)
            .background(Color.theme.gray900)
            .clipShape(
                RoundedRectangle(cornerRadius: 65, style: .continuous)
            )
    }
    
    private var billInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(bill.title)
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(1)
            
            HStack(alignment: .center, spacing: -4) {
                Text("total: ")
                    .foregroundColor(Color.theme.gray400)
                    .padding(.trailing, 4)
                
                Image("rupee")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color.theme.gray300)
                    .frame(width: 18, height: 18)
                
                Text(bill.total.withCommasString)
                    .foregroundColor(Color.theme.gray300)
            }
            .font(.callout)
            .fontWeight(.medium)
            AvatarRowView(people: bill.friends, size: 25, radius: 25)
        }
    }
    
    private var progress: some View {
        VStack {
            Text(bill.fractionPaid)
                .font(.title3)
                .bold()
                .foregroundColor(Color.theme.success)
            Text("paid")
                .font(.callout)
                .bold()
                .foregroundColor(Color.theme.appWhite)
        }
    }
}
