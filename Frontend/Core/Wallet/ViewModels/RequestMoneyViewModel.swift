//
//  RequestMoneyViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 10/10/22.
//

import Foundation
import Combine

@MainActor
class RequestMoneyViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var amount = ""
    @Published var requestee: User?
    @Published var friends: [User] = DeveloperPreview.shared.friends
    
    @Published var titleError: String?
    @Published var descriptionError: String?
    @Published var amountError: String?
    @Published var requesteeError: String?
    
    @Published var isFormDisabled = true
    @Published var isLoading = true
    @Published var isSubmitting = false
    @Published var toast: Toast?
    
    var bag = Set<AnyCancellable>()
    
    func getFriends() async {
        do {
            let response: FriendsResponse = try await ApiManager.shared.get(ApiConstants.GET_FRIENDS)
            if(response.ok) {
                friends = response.friends!
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch let error { 
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func selectFriend(friend: User) {
        self.requestee = friend
    }
    
    func validate() {
        $title
            .sink { [weak self] title in
                if(title.isEmpty || title.count < 10) {
                    self?.titleError = "title is too short"
                    self?.isFormDisabled = true
                } else if(title.count > 150) {
                    self?.titleError = "title is too long"
                    self?.isFormDisabled = true
                } else {
                    self?.titleError = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
        
        
        $amount
            .sink { [weak self] amount in
                if(amount.isEmpty) {
                    self?.amountError = "amount is required"
                    self?.isFormDisabled = true
                } else {
                    self?.amountError = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
        
        $description
            .sink { [weak self] description in
                if(description.isEmpty || description.count < 35) {
                    self?.descriptionError = "description is too short"
                    self?.isFormDisabled = true
                } else if(description.count > 150) {
                    self?.descriptionError = "description is too long"
                    self?.isFormDisabled = true
                } else {
                    self?.descriptionError = nil
                    self?.isFormDisabled = false
                }
            }
            .store(in: &bag)
    }
    
    func sendMoneyRequest(onSubmit: () -> Void) async {
        validate()
        if(isFormDisabled) { return }
        
        isSubmitting = true
        guard let requestee = self.requestee else { return }
        let sendMoneyRequestBody = RequestMoneyViewRequest(title: self.title, description: self.description, amount: Int(self.amount)!, requesteeId: requestee.id)
        do {
            let response: BaseResponse = try await ApiManager.shared.post(ApiConstants.SEND_MONEY_REQUEST, body: sendMoneyRequestBody)
            if(response.ok) {
                toast = Toast(type: .info, title: "woohoo!", message: "money request sent successfully")
                try await Task.sleep(nanoseconds: 1_000_000_000)
                onSubmit()
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch  {
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        
        isSubmitting = false
    }
    
    private func clearForm() {
        title = ""
        description = ""
        amount = "0"
    }
}
