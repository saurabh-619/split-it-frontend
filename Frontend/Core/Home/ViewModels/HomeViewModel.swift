//
//  HomeViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/09/22.
//

import CoreData

@MainActor
class HomeViewModel: ObservableObject {
    @Published var friends = [User]()
    @Published var friendRequests = [FriendRequest]()
    @Published var toast: Toast?
    @Published var isLoading = true
    
    func getFriends() async {
        do {
            isLoading = true
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
}
