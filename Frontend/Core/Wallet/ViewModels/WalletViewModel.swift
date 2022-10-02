//
//  WalletViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 02/10/22.
//

import Foundation

@MainActor
class WalletViewModel: ObservableObject {
    @Published var toast: Toast?
    @Published var isLoading = true
    @Published var isToMeSelected = true
    @Published var statusChosen = MoneyRequestStatus.PENDING
    
    @Published var moneyRequests = DeveloperPreview.shared.moneyRequests
 
    
    func getMoneyRequests() async {
        do {
            let response: MoneyRequestsResponse = try await ApiManager.shared.get((isToMeSelected ? ApiConstants.MONEY_REQUESTS_TO_ME : ApiConstants.MONEY_REQUESTS_BY_ME) + "=\(statusChosen.rawValue)")
            
            print(response)
            if(response.ok) {
                moneyRequests = response.moneyRequests
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch {
            toast = Toast(type: .error, title: "ohh oh", message: error.localizedDescription)
        }
        isLoading = false
    }
}
