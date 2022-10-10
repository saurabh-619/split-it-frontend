//
//  EditMoneyRequestViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 09/10/22.
//

import Foundation
import SwiftUI

@MainActor
class EditMoneyRequestViewModel: ObservableObject {
    @Published var title: String
    @Published var description: String
    @Published var amount: String
    
    @Published var titleError: String?
    @Published var descriptionError: String?
    @Published var amountError: String?
    
    @Published var requestId: Int
    @Published var transactionId: Int
    
    @Published var isLoading = false
    @Binding var toast: Toast?
    
    init(request: MoneyRequest, toast: Binding<Toast?>) {
        self.title = request.title
        self.description = request.description
        self.amount = String(request.amount)
        self.requestId = request.id
        self.transactionId = request.transactionId!
        self._toast = toast
    }
    
    func editMoneyRequest() async {
        do {
            let updateBody = EditMoneyRequestRequest(title: self.title, description: self.description, amount: Int(self.amount) ?? 0, requestId: self.requestId, transactionId: self.transactionId)
            let response: BaseResponse = try await ApiManager.shared.patch(ApiConstants.MONEY_REQUESTS_EDIT, body: updateBody)
            if(response.ok) {
                toast = Toast(title: "woohoo", message: "money request succefully edited")
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch {
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
    }
}
