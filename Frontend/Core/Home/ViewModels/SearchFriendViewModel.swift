//
//  SearchFriendViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/09/22.
//

import Foundation
import Combine

@MainActor
class SearchFriendViewModel: ObservableObject {
    @Published var query = String()
    @Published var count: Int?
    @Published var results = [User]()
    @Published var isLoading = true
    
    @Published var toast: Toast?
    
    init() {
        self.subscribeToQuery()
    }
    
    func subscribeToQuery() {
        $query
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .flatMap({[weak self] myQuery in
                Future { _ in
                    Task {
                        await self?.searchUsers()
                    }
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .assign(to: &$query)
    }
    
    func searchUsers() async {
        if query.isEmpty {
            results = []
            return
        }
        
        do {
            isLoading = true
            let response: SearchUsersResponse = try await ApiManager.shared.get("\(ApiConstants.SEARCH_USERS)=\(query)")
            if(response.ok) {
                results = response.results!
                count = response.size!
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch let error {
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        isLoading = false
    }
}
