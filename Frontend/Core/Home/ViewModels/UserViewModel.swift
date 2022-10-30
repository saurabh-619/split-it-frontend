//
//  UserViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 27/09/22.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: User = DeveloperPreview.shared.user
    @Published var friendRequestId: Int?
    @Published var isFriend: Bool = false
    @Published var isPending: Bool = false
    @Published var isLoading: Bool = true
    @Published var isDisabled: Bool = false
    @Published var moneyRequests = DeveloperPreview.shared.moneyRequests

    @Published var followBtnText = ""
    @Published var toast: Toast?
    
    func getUser(userId: Int) async {
        isLoading = true
        do {
            let response: UserWithFriendshipStatus = try await ApiManager.shared.get("\(ApiConstants.SEARCH_USER_WITH_FRIENDSHIP_STATUS)/\(userId)")
            if(response.ok) {
                user = response.user
                isFriend = response.isFriend
                if let friendRequestIdData = response.friendRequestId {
                    friendRequestId = friendRequestIdData
                }
                isPending = response.friendshipStatus != nil ? response.friendshipStatus == "pending" : false
                moneyRequests = response.moneyRequests
                getFollowBtnText()
            } else {
                throw NetworkError.backendError(response.error!)
            }
        } catch {
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func getFollowBtnText() {
        if(isFriend) {
            followBtnText = "unfriend"
        } else {
            // user not a friend
            if(isPending) {
                followBtnText = "pending"
                isDisabled = true
            } else {
                // not a friend and not pending request
                followBtnText = "add friend"
            }
        }
    }
    
    func setFollowBtnText(text: FriendRequestStatus) {
        switch text {
        case .SEEN:
            followBtnText = "seen"
            isDisabled = true
        case .PENDING:
            followBtnText = "pending"
            isDisabled = true
        case .ACCEPTED:
            followBtnText = "unfriend"
        case .REJECTED:
            followBtnText = "rejected"
        case .UNFRIENDED:
            followBtnText = "add friend"
        }
    }
    
    func addFriend() async {
        let sendFriendRequestBody = SendFriendRequestRequest(requesteeId: user.id)
        do {
            let response: BaseResponse = try await ApiManager.shared.post(ApiConstants.SEND_FRIEND_REQUEST, body: sendFriendRequestBody)
            if(response.ok) {
                setFollowBtnText(text: FriendRequestStatus.PENDING)
                toast = Toast(title: "woohoo", message: "friend request to \(user.username) sent successfully")
            } else {
                throw NetworkError.backendError(response.error!)
            }
        } catch {
            toast = Toast(type: .error, title: "ohh oh", message: error.localizedDescription)
        }
    }
    
    func unfriendTheFriend() async {
        guard let friendRequestId = friendRequestId else { return }
        
        let updateStatusBody = UpdateFriendRequestStatusRequest(requestId: friendRequestId, status: FriendRequestStatus.UNFRIENDED.rawValue)
        do {
            let response: BaseResponse = try await ApiManager.shared.patch(ApiConstants.CHANGE_FRIEND_REQUEST_STATUS, body: updateStatusBody)
            if(response.ok) {
                toast = Toast(type: .info, title: "woohoo!", message: "unfriended \(user.username) successfully")
                setFollowBtnText(text: FriendRequestStatus.UNFRIENDED)
            } else {
                throw NetworkError.backendError(response.error!)
            }
        } catch {
            toast = Toast(type: .error,title: "ohh ho!", message: error.localizedDescription)
        }
    }
}
