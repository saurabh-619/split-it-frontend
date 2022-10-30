//
//  AddBillItemSheetView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 22/10/22.
//

import SwiftUI

struct AddBillItemSheetView: View {
    @ObservedObject var vm: AddViewModel
    @Environment(\.dismiss) var dismiss
    
    let onSuccess: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            heading
            form
            friends
            Spacer()
            ActionButtonView(text: "add") {
                vm.addBillItem(onSuceess: {
                    onSuccess()
                    dismiss()
                })
            }
        }
        .padding(20)
        .backgroundColor()
        .onAppear {
            vm.clearBillItemInfo()
        }
    }
}

struct AddBillItemSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillItemSheetView(vm: AddViewModel(), onSuccess: {})
            .preferredColorScheme(.dark)
    }
}


extension AddBillItemSheetView {
    private var heading: some View {
        SheetHeadingView(title: "add new bill item")
            .padding(.bottom, 25)
    }
    
    private var form: some View {
        Group {
            TextFieldView(placeholder: "name", text: $vm.name, errorMsg: vm.nameError)
            TextFieldView(placeholder: "description", text: $vm.billItemDescription, errorMsg: vm.billItemDescriptionError)
            HStack(alignment: .top) {
                TextFieldView(placeholder: "price", text: $vm.price, isNumber: true, errorMsg: vm.priceError)
                    .padding(.trailing, 4)
                TextFieldView(placeholder: "quantity", text: $vm.quantity, isNumber: true, errorMsg: vm.quantityError)
            }
            .padding(.bottom, 16)
        }
    }
    
    private struct friendUI: View {
        let friend: User
        let hasBorder: Bool
        let onClick: () -> Void
        
        var body: some View {
            Button {
                withAnimation(.spring()) {
                    onClick()
                }
            } label: {
                VStack(spacing: 4) {
                    AvatarView(url: friend.avatar, hasBorder: hasBorder, size: 45.0)
                    Text(friend.username)
                        .font(.footnote)
                        .foregroundColor(Color.theme.gray400)
                }
            }
        }
    }
    
    private var friends: some View {
        Group {
            SectionTitleView(title: "choose friends")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 8) {
                    ForEach(vm.selectedFriends) { friend in
                        friendUI(friend: friend, hasBorder: vm.billItemFriends.contains(friend)) {
                            vm.addOrRemoveBillItemFriend(friend:friend)
                        }
                    }
                }
                .padding(.bottom, 36)
            }
        }
    }
}
