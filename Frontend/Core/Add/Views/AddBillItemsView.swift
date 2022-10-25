//
//  AddBillItemsView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 22/10/22.
//

import SwiftUI

struct AddBillItemsView: View {
    @ObservedObject var vm: AddViewModel
    
    @State var showAddBillItem = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            heading
            items
        }
        .animation(.spring(), value: vm.billItems.count)
        .sheet(isPresented: $showAddBillItem) {
            AddBillItemSheetView(vm: vm, onSuccess: {
                showAddBillItem.toggle()
            })
        }
    }
}

struct AddBillItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillItemsView(vm: AddViewModel())
            .preferredColorScheme(.dark)
    }
}


extension AddBillItemsView {
    private var heading: some View {
        HStack {
            SectionTitleView(title: "bill items")
            Spacer()
            Button {
                showAddBillItem.toggle()
            } label: {
                Text("add")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.white60)
            }
        }
        .padding(.bottom, 24)
    }
    
    @ViewBuilder
    func QuantityView(quantity: Int, color: Color = Color.theme.white45) -> some View {
        HStack(alignment: .center, spacing: 2) {
            Text("x")
                .font(.caption)
                .bold()
            Text("\(quantity)")
                .bold()
        }
        .font(.subheadline)
        .foregroundColor(color)
    }
    
    @ViewBuilder
    private func BillItemView(billItem: BillItemInput) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(billItem.name)
                    .bold()
                    .padding(.bottom, 4)
                Spacer()
                Button {
                    vm.removeBillItem(uuid: billItem.id)
                } label: {
                    Image("close")
                        .resizable()
                        .foregroundColor(Color.theme.appWhite)
                        .frame(width: 12, height: 12)
                }
            }
            
            Text(billItem.description)
                .font(.footnote)
                .foregroundColor(Color.theme.white30)
                .lineLimit(5)
                .padding(.bottom, 12)
            
            HStack(alignment: .bottom) {
                AvatarRowView(people: vm.selectedFriends.filter{billItem.friendIds.contains($0.id)}, size: 25, hasBorder: false)
                Spacer()
                PriceView(price: billItem.price)
                    .padding(.trailing, 8)
                QuantityView(quantity: billItem.quantity)
                    .padding(.bottom, 2)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(minHeight: 150)
        .background(Color.theme.cardBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
        )
        .padding(.horizontal, 16)
        .shadow(color: Color.theme.accent.opacity(0.2), radius: 15, x: 5, y: 8)
        .transition(.slide.combined(with: .opacity))
    }
    
    @ViewBuilder
    private var items: some View {
        if vm.billItems.isEmpty {
            Text("no bill items were added yet")
                .font(.footnote)
                .foregroundColor(Color.theme.white60)
                .frame(height: 120, alignment: .center)
                .frame(maxWidth: .infinity)
        } else {
            LazyVStack(spacing: 28) {
                ForEach(vm.billItems.reversed(), id: \.id) { billItem in
                    BillItemView(billItem: billItem)
                }
            }
        }
    }
}
