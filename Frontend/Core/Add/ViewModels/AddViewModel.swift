//
//  AddViewModel.swift
//  Frontend
//
//  Created by Saurabh Bomble on 19/10/22.
//

import Foundation
import Combine

@MainActor
class AddViewModel: ObservableObject {
    @Published var isLoading = true
    //    @Published var friends = [User]()
    @Published var friends = DeveloperPreview.shared.friends
    
    @Published var toast: Toast?
    @Published var step = 0
    
    // basic info
    @Published var title = ""
    @Published var description = ""
    
    @Published var titleError: String?
    @Published var descriptionError: String?
    @Published var isNextDisabled = false
    
    // friends
    @Published var selectedFriends = [User]()
    
    // Bill info
    @Published var billItems = [BillItemInput]()
    @Published var billItemFriends = [User]()
    
    @Published var name = ""
    @Published var price = ""
    @Published var quantity = ""
    @Published var billItemDescription = ""
    
    @Published var nameError: String?
    @Published var billItemDescriptionError: String?
    @Published var priceError: String?
    @Published var quantityError: String?
    @Published var isAddBillItemDisabled = false
    
    @Published var total = 0
    @Published var tax = "0"
    @Published var equalSplit = 0
    @Published var splitTotal = 0
    @Published var splits = [SplitInput]()
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        $billItems
            .sink { _ in
                self.setTotalAndSplit()
                self.setSplitTotal()
            }
            .store(in: &bag)
        
        $tax
            .sink { _ in
                self.setTotalAndSplit()
                self.setSplitTotal()
            }
            .store(in: &bag)
        
        $splits
            .sink { _ in
                self.setSplitTotal()
            }
            .store(in: &bag)
    }
    
    func setTotalAndSplit() {
        guard self.selectedFriends.count != 0 else { return }
        
        self.total = self.billItems.reduce(0) { acc, item in
            item.quantity * item.price
        } + (Int(self.tax) ?? 0)
        
        self.createSplitInputs(split: Int(Double(self.total)/Double(self.selectedFriends.count).rounded(.up)))
    }
    
    func setSplitTotal() {
        self.splitTotal = self.splits.reduce(0, { acc,splitInput in
            acc + (Int(splitInput.splitString) ?? 0)
        })
    }
    
    func getFriends() async {
        do {
            isLoading = true
            let response: FriendsResponse = try await ApiManager.shared.get(ApiConstants.GET_FRIENDS)
            if(response.ok) {
                self.friends = response.friends!
            } else {
                throw NetworkError.backendError(response.error ?? "")
            }
        } catch let error {
            toast = Toast(type: .error, title: "ohh oh!", message: error.localizedDescription)
        }
        isLoading = false
    }
    
    func validateBasicInfo() {
        $title
            .sink { [weak self] title in
                guard let self else { return }
                
                if title.isEmpty {
                    self.titleError = "title can't be empty"
                } else if title.count < 8 {
                    self.titleError = "title is too short"
                } else if title.count > 200 {
                    self.titleError = "title is too long"
                } else {
                    self.titleError = nil
                    self.isNextDisabled = false
                }
            }
            .store(in: &bag)
        
        $description
            .sink { [weak self] description in
                guard let self else { return }
                
                if description.isEmpty {
                    self.descriptionError = "description can't be empty"
                } else if description.count < 20 {
                    self.descriptionError = "description is too short"
                } else if description.count > 3000 {
                    self.descriptionError = "description is too long"
                } else {
                    self.descriptionError = nil
                    self.isNextDisabled = false
                }
            }
            .store(in: &bag)
        
        if(self.titleError != nil || self.descriptionError != nil) {
            self.isNextDisabled = true
        }
    }
    
    func nextStep() {
        //        validate()
        if(!isNextDisabled) {
            self.step = self.step == 4 ? 4 : self.step + 1
        }
    }
    
    func prevStep() {
        self.step = self.step == 0 ? 0 : self.step - 1
    }
    
    func clearSelectedFriends() {
        self.selectedFriends.removeAll()
    }
    
    func addOrRemoveSelectedFriend(friend: User) {
        let index = self.selectedFriends.firstIndex(of: friend)
        
        if(index == nil) {
            self.selectedFriends.append(friend)
        } else {
            self.selectedFriends.remove(at: index!)
        }
    }
    
    func validateBillItem() {
        $name
            .sink { [weak self] name in
                guard let self else { return }
                
                if name.isEmpty {
                    self.nameError = "name can't be empty"
                } else if name.count < 8 {
                    self.nameError = "name is too short"
                } else if name.count > 200 {
                    self.nameError = "name is too long"
                } else {
                    self.nameError = nil
                    self.isAddBillItemDisabled = false
                }
            }
            .store(in: &bag)
        
        $billItemDescription
            .sink { [weak self] billItemDescription in
                guard let self else { return }
                
                if billItemDescription.isEmpty {
                    self.billItemDescriptionError = "description can't be empty"
                } else if billItemDescription.count < 20 {
                    self.billItemDescriptionError = "description is too short"
                } else if billItemDescription.count > 3000 {
                    self.billItemDescriptionError = "description is too long"
                } else {
                    self.billItemDescriptionError = nil
                    self.isAddBillItemDisabled = false
                }
            }
            .store(in: &bag)
        
        $price
            .sink { [weak self] price in
                guard let self else { return }
                
                if price.isEmpty {
                    self.priceError = "price field can't be empty"
                }  else if Int(price) ?? 0 == 0 {
                    self.priceError = "price can't be 0"
                } else {
                    self.priceError = nil
                    self.isAddBillItemDisabled = false
                }
            }
            .store(in: &bag)
        
        $quantity
            .sink { [weak self] quantity in
                guard let self else { return }
                
                if quantity.isEmpty {
                    self.quantityError = "quantity field can't be empty"
                } else if Int(quantity) ?? 0 == 0 {
                    self.quantityError = "quantity can't be 0"
                } else {
                    self.quantityError = nil
                    self.isAddBillItemDisabled = false
                }
            }
            .store(in: &bag)
        
        if(self.nameError != nil || self.billItemDescriptionError != nil || self.priceError != nil || self.quantityError != nil) {
            self.isAddBillItemDisabled = true
        }
    }
    
    func clearBillItemInfo() {
        self.name = ""
        self.billItemDescription = ""
        self.price = ""
        self.quantity = ""
        
        self.isAddBillItemDisabled = false
        self.billItemFriends = []
        
        self.nameError = nil
        self.billItemDescriptionError = nil
        self.priceError = nil
        self.quantityError = nil
    }
    
    
    func addOrRemoveBillItemFriend(friend: User) {
        let index = self.billItemFriends.firstIndex(of: friend)
        if(index == nil) {
            self.billItemFriends.append(friend)
        } else {
            self.billItemFriends.remove(at: index!)
        }
    }
    
    func addBillItem(onSuceess: () -> Void) {
        validateBillItem()
        if(!isAddBillItemDisabled && !self.billItemFriends.isEmpty) {
            self.billItems.append(BillItemInput(billId: nil, name: self.name, description: self.billItemDescription, price: Int(self.price) ?? 0, friendIds: self.billItemFriends.map {$0.id}, quantity: Int(self.quantity) ?? 0))
            onSuceess()
        }
    }
    
    func removeBillItem(uuid: UUID) {
        let index = self.billItems.firstIndex(where: {$0.id == uuid})
        if let index {
            self.billItems.remove(at: index)
        }
    }
    
    func createSplitInputs(split: Int) {
        self.equalSplit = split
        
        for friend in self.selectedFriends {
            var friendTotal = Int(((Double(self.tax) ?? 0) / Double(self.selectedFriends.count)).rounded(.up))
            friendTotal += billItems.reduce(0, { acc, billItem in
                return billItem.friendIds.contains(friend.id) ? acc + billItem.price : acc + 0
            })
            
            let index = self.splits.firstIndex{ $0.friendId == friend.id}
            if(index == nil) {
                self.splits.append(SplitInput(friendId: friend.id, split: friendTotal))
            } else {
                self.splits[index!].split = friendTotal
                self.splits[index!].splitString = String(friendTotal)
            }
        }
    }
}
