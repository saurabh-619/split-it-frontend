//
//  HomeViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/09/22.
//

import CoreData

@MainActor
class HomeViewModel: ObservableObject {
    @Published var toast: Toast?
    @Published var isFetching = true
}
