//
//  TransactionDetailsSheetViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/10/22.
//

import Foundation
import SwiftUI

@MainActor
class TransactionDetailsSheetViewModel: ObservableObject {
    @Binding var toast: Toast?
    @Published var isLoading = false
    
    init(toast: Binding<Toast?>) {
        self._toast = toast
    }
    
    func settleSplit(billId: Int, transactionId: Int, onComplete: () -> Void) async {
        isLoading = true
        let settleSplitBody = SettleSplitRequest(billId: billId, transactionId: transactionId)
        
        do {
            let response: BaseResponse = try await ApiManager.shared.patch(ApiConstants.SETTLE_THE_SPLIT, body: settleSplitBody)
            if(response.ok) {
                onComplete()
                try await Task.sleep(nanoseconds: 500_000_000)
                toast = Toast(title: "woohoo!", message: "split was successfully settled")
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch {
                onComplete()
                try? await Task.sleep(nanoseconds: 500_000_000)
                toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        isLoading = false
    }
}
