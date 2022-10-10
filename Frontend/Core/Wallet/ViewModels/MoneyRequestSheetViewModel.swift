//
//  MoneyRequestSheetViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 07/10/22.
//

import Foundation
import SwiftUI

@MainActor
class MoneyRequestSheetViewModel: ObservableObject {
    @Binding var toast: Toast?
    @Published var requesteeRemark = ""
    @Published var status = MoneyRequestStatus.PENDING

    @Published var isLoading = false
    @Published var showRemarkPopup = false
    
    init(toast: Binding<Toast?>) {
        self._toast = toast
    }
    
    func changeStatus(status: MoneyRequestStatus) {
        self.status = status
    }
    
    func onAddRemarkClicked(status: MoneyRequestStatus) {
        changeStatus(status: status)
        self.showRemarkPopup = true
    }
    
    func changeMoneyRequestStatus(request: MoneyRequest) async {
        let requestBody = MoneyRequestStatusUpdateRequest(requestId: request.id, transactionId: request.transactionId!, status: status.rawValue, requesteeRemark: self.requesteeRemark == "" ? nil : self.requesteeRemark)
        do {
            let response: BaseResponse = try await ApiManager.shared.patch(ApiConstants.MONEY_REQUEST_STATUS_UPDATE, body: requestBody)
            if(response.ok) {
                self.toast = Toast(title: "success", message: "request status changed to \(status.rawValue)")
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch {
            self.toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        self.showRemarkPopup = false
    }
    
}
