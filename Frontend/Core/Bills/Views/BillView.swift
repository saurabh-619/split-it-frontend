//
//  BillView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/10/22.
//

import SwiftUI

struct BillView: View {
    let bill: Bill
    
    @ObservedObject var counter: Counter
    @State var selectedUser: UserWithPaymentInfo?
    
    init(bill: Bill) {
        self.bill = bill
        self.counter = Counter(speed: 0.01, end: bill.fractionPaid)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    heading
                    billInfo
                    billPeople
                    transactionDetails
                }
                .padding(20)
                .padding(.bottom, 50)
            }
            .backgroundColor()
            .onAppear {
                self.counter.start()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct BillView_Previews: PreviewProvider {
    static var previews: some View {
        BillView(bill: self.dev.bill)
            .preferredColorScheme(.dark)
    }
}

extension BillView {
    private var heading: some View {
        NavbarView(title: "bill details")
            .padding(.bottom, 45)
    }
    
    private var progressColor: Color {
        switch Double(bill.fractionPaid) ?? 0.0 {
        case 0.0...0.33:
            return Color.theme.danger
        case 0.34...0.66:
            return Color.theme.warning
        case 0.67...1.0:
            return Color.theme.success
        default:
            return Color.theme.success
        }
    }
    
    private var billInfo: some View {
        var billPaidPercentage: some View {
            BillProgressView(fractionPaid: String(counter.count), size: 120.0, lineWidth: 15.0, fontSize1: 18, fontSize2: 14)
                .padding(.bottom, 32)
        }
        
        var billTitle: some View {
            Text(bill.title)
                .font(.title)
                .bold()
                .lineLimit(2)
                .foregroundColor(Color.theme.accent)
                .padding(.bottom, 9)
        }
        
        var billDate: some View {
            Text(bill.createdAt.dateFromISO)
                .font(.caption)
                .multilineTextAlignment(.trailing)
                .bold()
                .lineLimit(2)
                .foregroundColor(Color.theme.white80)
                .padding(.bottom, 24)
        }
        
        var billDescription: some View {
            VStack {
                Text(bill.description)
                    .font(.callout)
                    .bold()
                    .foregroundColor(Color.theme.white30)
                    .multilineTextAlignment(.center)
                    .lineLimit(8)
                    .padding(.bottom, 16)
            }
        }
        
        return VStack(alignment: .center, spacing: 0) {
            billPaidPercentage
            billTitle
            billDate
            billDescription
        }
        .padding(20)
        .padding(.top, 24)
        .frame(maxWidth: .infinity)
        .background(Color.theme.darkerGray)
        .clipShape(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .padding(.bottom, 24)
    }
    
    @ViewBuilder
    func userRow(isLeader: Bool, user: UserWithPaymentInfo) -> some View {
        Button {
            selectedUser = user
        } label: {
            HStack(alignment: .center, spacing: 8) {
                AvatarView(url: user.avatar, hasBorder: false, size: 54)
                VStack(alignment: .leading) {
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.callout)
                        .bold()
                        .foregroundColor(Color.theme.white80)
                    Text("@\(user.username)")
                        .font(.caption)
                        .foregroundColor(Color.theme.gray300)
                }
                Spacer()
                if(!isLeader) {
                    PriceView(price: user.paymentInfo.amount, color: user.paymentInfo.hasPaid ? Color.theme.success : Color.theme.danger) 
                }
            }
        }
    }
    
    private var billLeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitleView(title: "leader")
            userRow(isLeader: true, user: bill.leader!)
        }
        .padding(.bottom, 24)
    }
    
    private var billFriends: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitleView(title: "friends")
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(bill.friends!) { friend in
                    userRow(isLeader: false, user: friend)
                }
            }
        }
        .padding(.bottom, 24)
    }
    
    private var billPeople: some View {
        VStack(alignment: .leading) {
            billLeader
            billFriends
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .sheet(item: $selectedUser) { user in
            UserView(id: user.id)
        }
    }
    
    private var transactionDetails: some View {
        var title: some View {
            VStack(alignment: .leading) {
                SectionTitleView(title: "transaction details", color: Color.theme.white60, fontWeight: .regular)
            }
            .padding(.bottom, 16)
        }
        
        @ViewBuilder
        func QuantityView(quantity: Int, color: Color = Color.theme.white45) -> some View {
            HStack(alignment: .bottom, spacing: 2) {
                Text("\(quantity)")
                    .bold()
                Text("x")
                    .font(.subheadline)
                    .bold()
            }
            .font(.callout)
            .foregroundColor(color)
        }
        
        @ViewBuilder
        func ItemView(billItem: BillItem) -> some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(billItem.item.name)
                    .font(.title3)
                    .bold()
                    .lineLimit(2)
                HStack {
                    PriceView(price: billItem.item.price, color: Color.theme.white45)
                    Spacer()
                    QuantityView(quantity: billItem.quantity)
                    Spacer()
                    PriceView(price: billItem.total, color: Color.theme.appWhite, fontWeight: .bold)
                }
                AvatarRowView(people: billItem.friends, size: 24)
            }
        }
        
        var items: some View {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(bill.billItems!.indices, id: \.self) { index in
                    ItemView(billItem: bill.billItems![index])
                    TransactionDividerView(isDashed: index != bill.billItems!.count-1)
                        .padding(.vertical, 8)
                }
            }
        }
        
        @ViewBuilder
        func LabelPriceView(title: String, price: Int, fontSize: Double = 16, color: Color = Color.theme.appWhite) -> some View {
            HStack {
                Text(title)
                    .foregroundColor(Color.theme.white45)
                Spacer()
                PriceView(price: price, fontSize: fontSize, color: color, fontWeight: .bold)
            }
        }
        
        var priceDetails: some View {
            VStack(alignment: .leading, spacing: 10) {
                LabelPriceView(title: "subtotal", price: bill.totalWithoutTax, color: Color.theme.white45)
                LabelPriceView(title: "tax", price: bill.tax, color: Color.theme.white45)
                LabelPriceView(title: "total spent", price: bill.total, fontSize: 22.0, color: Color.theme.appWhite)
                LabelPriceView(title: "received amount", price: bill.paidAmount, color: progressColor)
            }
        }
        
        return VStack(alignment: .leading) {
            title
            items
            priceDetails
        }
        .padding(20)
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.darkerGray)
        .clipShape(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .padding(.bottom, 24)
    }
}
