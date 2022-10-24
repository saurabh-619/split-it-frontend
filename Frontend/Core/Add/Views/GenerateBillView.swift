//
//  GenerateBillView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/10/22.
//

import SwiftUI

struct GenerateBillView: View {
    @ObservedObject var vm: AddViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            billAmount
            SectionTitleView(title: "details")
            tax
            splitsHeading
            splits
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//        .onChange(of: self.vm.billItems, perform: { newValue in
//            vm.setTotalAndSplit()
//        })
//        .onChange(of: self.vm.tax, perform: { tax in
//            vm.setTotalAndSplit()
//        })
    }
}

struct GenerateBillView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateBillView(vm: AddViewModel())
            .preferredColorScheme(.dark)
    }
}

extension GenerateBillView {
    @ViewBuilder
    private func PriceView(price: Int, size: CGFloat = 28, color: Color = Color.theme.accent) -> some View {
        HStack(spacing: 0) {
            Image("rupee")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .padding(.horizontal, -2)
            
            Text(price.withCommasString)
                .font(.system(size: size))
                .fontWeight(.bold)
        }
        .foregroundColor(color)
    }
    
    private var billAmount: some View {
        VStack {
            Text("total")
                .font(.subheadline)
                .foregroundColor(Color.theme.white60)
            PriceView(price: vm.total, size: 32)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color.theme.cardBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
        )
    }
    
    private var divider: some View {
        Divider()
            .background(Color.theme.gray400)
    }
    
    private var tax: some View {
        HStack {
            Text("tax")
                .foregroundColor(Color.theme.white60)
            Spacer()
            TextFieldView(placeholder: "tax", text: $vm.tax)
                .frame(width: 120)
        }
    }
    
    private var splitsHeading: some View {
        HStack {
            SectionTitleView(title: "splits")
            Spacer()
            PriceView(price: vm.splitTotal, size: 18.0, color: vm.splitTotal >= vm.total ? Color.theme.gray500 : Color.theme.danger)
        }
    }
    
    @ViewBuilder
    private func friendUI(friend: User) -> some View {
        HStack(spacing: 16) {
            CacheImageView(url: friend.avatar) { uiImage in
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .cornerRadius(35)
            }
            
            VStack(alignment: .leading) {
                Text("\(friend.firstName) \(friend.lastName)")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color.theme.white80)
                
                Text("@\(friend.username)")
                    .font(.subheadline)
                    .foregroundColor(Color.theme.white45)
            }
            Spacer()
            TextEditorView(placeholder: "split", splitString: $vm.splits.first {$0.friendId.wrappedValue == friend.id}?.splitString ?? .constant("0"))
        }
    }
    
    private var splits: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(vm.selectedFriends) { friend in
                    friendUI(friend: friend)
                }
            }
        }
    }
     
}
