//
//  EditMoneyRequestView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 09/10/22.
//

import SwiftUI

struct EditMoneyRequestView: View {
    let request: MoneyRequest
    @Binding var toast: Toast?
    var onClose: () -> Void
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm: EditMoneyRequestViewModel
    
    init(request: MoneyRequest, toast: Binding<Toast?>, onClose: @escaping () -> Void = {}) {
        self.request = request
        self._toast = toast
        self.onClose = onClose
        self._vm = StateObject(wrappedValue: EditMoneyRequestViewModel(request: request, toast: toast))
    }
    
    
    var body: some View {
        VStack {
            heading
            editFields
            Spacer()
            footer
        }
        .padding(20)
        .frame(maxHeight: .infinity, alignment: .top)
        .backgroundColor()
    }
}

struct EditMoneyRequestView_Previews: PreviewProvider {
    static var previews: some View {
        EditMoneyRequestView(request: self.dev.moneyRequest, toast: .constant(Toast(title: "", message: "")))
            .preferredColorScheme(.dark)
    }
}

extension EditMoneyRequestView {
    var heading: some View {
        SheetHeadingView(title: "edit request")
            .padding(.bottom, 45)
    }
    
    var editFields: some View {
        VStack(spacing: 24) {
            TextFieldView(placeholder: vm.title, text: $vm.title, errorMsg: vm.titleError)
            TextFieldView(placeholder: vm.description, text: $vm.description, errorMsg: vm.descriptionError)
            TextFieldView(placeholder: vm.amount, text: $vm.amount, isNumber: true, errorMsg: vm.amountError)
        } 
    }
    
    var footer: some View {
        ActionButtonView(text: "edit") {
            Task {
                dismiss()
                onClose()
                await vm.editMoneyRequest()
            }
        }
    }
}
