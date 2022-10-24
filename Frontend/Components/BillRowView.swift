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
        HStack(alignment: .center, spacing: 32) {
            icon
            billInfo
            Spacer()
            progress
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BillRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 45) {
            ForEach(self.dev.bills) { bill in
                BillRowView(isLeader: true, bill: bill)
            }
        }
        .preferredColorScheme(.dark)
    }
}


extension BillRowView {
    private var icon: some View {
        Image(isLeader ? "receive-money" : "send-money")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 26, height: 26)
            .foregroundColor(isLeader ? Color.theme.success : Color.theme.danger)
            .frame(width: 55, height: 55)
            .background(Color.theme.gray900)
            .clipShape(
                RoundedRectangle(cornerRadius: 65, style: .continuous)
            )
    }
    
    private var billInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(bill.title)
                .font(.headline)
                .foregroundColor(Color.theme.appWhite)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
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
            .font(.footnote)
            .fontWeight(.medium)
            AvatarRowView(people: bill.friends ?? [], size: 25, radius: 25)
        }
    }
    
    private var progress: BillProgressView {
        BillProgressView(fractionPaid: bill.fractionPaid, size: 60,lineWidth: 4.5, fontSize1: 12, fontSize2: 8)
    }
}
