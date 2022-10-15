//
//  BillView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/10/22.
//

import SwiftUI

struct BillView: View {
    let bill: Bill
    @State var selectedUser: User?
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    heading
                    billInfo
                    billPeople
                }
                .padding(20)
            }
            .backgroundColor()
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
    
    private var billPaidPercentage: some View {
        BillProgressView(fractionPaid: bill.fractionPaid, size: 120.0, lineWidth: 15.0, fontSize1: 18, fontSize2: 14)
            .padding(.bottom, 32)
    }
    
    private var billTitle: some View {
        Text(bill.title)
            .font(.title)
            .bold()
            .lineLimit(2)
            .foregroundColor(Color.theme.accent)
            .padding(.bottom, 9)
    }
    
    private var billDate: some View {
        Text(bill.createdAt.dateFromISO)
            .font(.caption)
            .multilineTextAlignment(.trailing)
            .bold()
            .lineLimit(2)
            .foregroundColor(Color.theme.white80)
            .padding(.bottom, 24)
    }
    
    private var billDescription: some View {
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
    
    private var billInfo: some View {
        VStack(alignment: .center, spacing: 0) {
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
    func userRow(user: User) -> some View {
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
        }
        .onTapGesture {
            selectedUser = user
        }
    }
    
    private var billLeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitleView(title: "leader")
            userRow(user: bill.leader)
        }
        .padding(.bottom, 24)
    }
    
    private var billFriends: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitleView(title: "friends")
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(bill.friends) { friend in
                    userRow(user: bill.leader)
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
}
