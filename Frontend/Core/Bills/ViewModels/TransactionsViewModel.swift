//
//  TransactionsViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/10/22.
//

import Foundation

@MainActor
class TransactionsViewModel: ObservableObject {
    // @Published var transactions = [Transaction]()
    @Published var transactions = DeveloperPreview.shared.transactions
    @Published var type = TransactionType.BILL
    @Published var state = TransactionState.PENDING
    
    @Published var isLoading = true
    @Published var toast: Toast?
    
    func getTransactions() async {
        isLoading = true 
        do {
            let response: GetTransactionsResponse = try await ApiManager.shared.get("\(ApiConstants.GET_TRANSACTIONS)&type=\(type.rawValue)&state=\(state.rawValue)")
            
            if(response.ok) {
                self.transactions = response.transactions
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch {
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        isLoading = false
    }
}
