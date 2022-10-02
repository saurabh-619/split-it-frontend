//
//  PendingFriendRequestsViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 01/10/22.
//

import SwiftUI


@MainActor
class PendingFriendRequestsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var buttonText = Array(repeating: "add", count: DeveloperPreview.shared.friendRequests.count)
    @Published var buttonTextColor = Array(repeating: Color.theme.accent, count: DeveloperPreview.shared.friendRequests.count)
    @Published var isButtonDisabled = Array(repeating: false, count: DeveloperPreview.shared.friendRequests.count)
    @Published var toast: Toast?
    @Published var friendRequests = DeveloperPreview.shared.friendRequests
    
    func getPendingFriendRequests() async {
        do {
            isLoading = true
            let response: PendingFriendRequestResponse = try await ApiManager.shared.get(ApiConstants.GET_FRIEND_REQUESTS)
            if(response.ok) {
                if let friendRequestsData = response.friendRequests {
                    friendRequests = friendRequestsData.map { FriendRequestWithRequester(id: $0.id, requester: $0.requester) }
                } else { friendRequests = [FriendRequestWithRequester]() }
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch let error {
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func onAcceptClicked(requestId: Int, index: Int) async {
        let updateStatusBody = UpdateFriendRequestStatusRequest(requestId: requestId, status: FriendRequestStatus.ACCEPTED.rawValue)
        do {
            let response: BaseResponse = try await ApiManager.shared.patch(ApiConstants.CHANGE_FRIEND_REQUEST_STATUS, body: updateStatusBody)
            if(response.ok) {
                toast = Toast(title: "woohoo!", message: "friend request accepted successfully")
                buttonText[index] = "added"
                buttonTextColor[index] = Color.theme.gray700
                isButtonDisabled[index] = true
            } else {
                throw NetworkError.backendError(response.error!)
            }
        } catch {
            toast = Toast(type: .error,title: "ohh ho!", message: error.localizedDescription)
        }
    } 
}
