//
//  MoneyRequestSheetView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 05/10/22.
//

import SwiftUI

struct MoneyRequestSheetView: View {
    let moneyRequest: MoneyRequest
    var isSent: Bool
    @Binding var toast: Toast?
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: MoneyRequestSheetViewModel
    
    @State var showEditSheet = false
    
    init(moneyRequest: MoneyRequest, isSent: Bool, toast: Binding<Toast?>) {
        self.moneyRequest = moneyRequest
        self.isSent = isSent
        self._toast = toast
        self._vm = StateObject(wrappedValue: MoneyRequestSheetViewModel(toast: toast))
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                heading
                content
            }
            AlertView(title: "remark", msg: "enter the remark you want to leave with the request status change", placeholder: "write the remark", isShown: $vm.showRemarkPopup, text: $vm.requesteeRemark, onSubmit: {
                Task {
                    dismiss()
                    await vm.changeMoneyRequestStatus(request:moneyRequest)
                }
            })
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .backgroundColor()
    }
}

struct MoneyRequestSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MoneyRequestSheetView(moneyRequest: self.dev.moneyRequest, isSent: true, toast: .constant(Toast(title: "", message: "")))
            .preferredColorScheme(.dark)
    }
}

extension MoneyRequestSheetView {
    var firstName: String {
        isSent ? moneyRequest.requester!.firstName : moneyRequest.requestee!.firstName
    }
    
    var lastName: String {
        isSent ? moneyRequest.requester!.lastName : moneyRequest.requestee!.lastName
    }
    
    private var heading: some View {
        Rectangle()
            .fill(Color.theme.accent)
            .frame(height: 250)
            .overlay {
                headingOverlay
            }
            .padding(-20)
    }
    
    private var headingOverlay: some View {
        var overlayHeader: some View {
            HStack {
                CacheImageView(url: isSent ? moneyRequest.requester!.avatar : moneyRequest.requestee!.avatar) { image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 50, style: .continuous)
                        )
                }
                Spacer()
                Text("\(firstName) \(lastName)")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
        
        var amount: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text("total".uppercased())
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.gray700)
                
                HStack(spacing: 0) {
                    Image("rupee")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                        .padding(.horizontal, -8)
                    
                    Text(moneyRequest.amount.withCommasString)
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                }
                .foregroundColor(Color.theme.background)
            }
        }
        
        return VStack(alignment: .leading) {
            overlayHeader
            Spacer()
            amount
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private var content: some View {
        var title: some View {
            Text(moneyRequest.title)
                .font(.title3)
                .lineLimit(3)
                .fontWeight(.medium)
        }
        
        var statusInfo: some View {
            HStack(spacing: 16) {
                IconLabelView(icon: "activity", text: moneyRequest.status)
                IconLabelView(icon: "calendar", text: moneyRequest.createdAt.dateFromISO)
            }
            .padding(.bottom, 24)
        }
        
        var description: some View {
            Text(moneyRequest.description)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.gray400)
                .lineLimit(12)
                .padding(.bottom, 24)
        }
        
        var remark: some View {
            Group {
                if let remark = moneyRequest.requesteeRemark {
                    HStack {
                        Text("remark:")
                            .foregroundColor(Color.theme.white80)
                        Text(remark)
                            .lineLimit(4)
                            .foregroundColor(Color.theme.white60)
                    }
                    .font(.callout)
                    .fontWeight(.medium)
                    .padding(.bottom, 24)
                }
            }
        }
        
        var editButton: some View {
            ActionButtonView(text: "edit") {
                self.showEditSheet.toggle()
            }
            .sheet(isPresented: $showEditSheet) {
                EditMoneyRequestView(request: moneyRequest, toast: $toast, onClose: {
                    dismiss()
                })
            }
        }
        
        var sendMoneyButton: some View {
            ActionButtonView(text: "send money") {
                Task {
                    vm.changeStatus(status: MoneyRequestStatus.PAID)
                    await vm.changeMoneyRequestStatus(request: moneyRequest)
                    dismiss()
                }
            }
        }
        
        var acceptButton: some View {
            ActionButtonView(text: "accept") {
                vm.onAddRemarkClicked(status: MoneyRequestStatus.ACCEPTED)
            }
        }
        
        var rejectButton: some View {
            ActionButtonView(text: "reject", fontColor: Color.theme.white60, bgColor: Color.theme.gray800) {
                vm.onAddRemarkClicked(status: MoneyRequestStatus.REJECTED)
            }
        }
        
        var actionButtons: some View {
            HStack {
                if !isSent {
                    editButton
                } else if moneyRequest.status == MoneyRequestStatus.PENDING.rawValue {
                    Group {
                        rejectButton
                        acceptButton
                    }
                } else if moneyRequest.status == MoneyRequestStatus.ACCEPTED.rawValue {
                    sendMoneyButton
                }
            }
        }
        
        return VStack(alignment: .leading, spacing: 8) {
            title
            statusInfo
            description
            remark
            Spacer()
            actionButtons
        }
        .padding(.top, 40)
    }
}
