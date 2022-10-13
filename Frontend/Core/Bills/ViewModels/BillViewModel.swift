//
//  BillViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 12/10/22.
//

import Foundation

@MainActor
class BillViewModel: ObservableObject {
    @Published var toast: Toast?
//    @Published var bills = [Bill]()
    @Published var bills = DeveloperPreview.shared.bills
    
    @Published var isLoading = true
    @Published var isLeaderTab = true
    
    func getBills() async {
        do {
            let response: BillsResponse = try await ApiManager.shared.get(isLeaderTab ? ApiConstants.GET_LEADER_BILLS : ApiConstants.GET_SPLIT_BILLS)
            if(response.ok) {
                self.bills = response.bills
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch {
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        isLoading = false
    }
}
