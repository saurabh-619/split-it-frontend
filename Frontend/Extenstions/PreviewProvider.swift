//
//  PreviewProvider.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/09/22.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    private init(){}
    
    var wallet: Wallet {
        Wallet(id: 1, version: 1, ownerId: 1, balance: 5000, createdAt: "", updatedAt: "", deletedAt: "")
    }
    
    var user: User {
        User(id: 1, version: 1, username: "jon", firstName: "Jon", lastName: "Doe", email: "jon@gmail.com", avatar: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80", walletId: 1, wallet: self.wallet, createdAt: "", updatedAt: "", deletedAt: "")
    }
    
    var user2: User {
        User(id: 2, version: 2, username: "sam007", firstName: "Sam", lastName: "Browsky", email: "sam@gmail.com", avatar: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2960&q=80", walletId: 2, wallet: self.wallet, createdAt: "", updatedAt: "", deletedAt: "")
    }
    
    var userWithoutWallet: User {
        User(id: 1, version: 1, username: "jon", firstName: "Jon", lastName: "Doe", email: "jon@gmail.com", avatar: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80", walletId: 1, wallet: nil, createdAt: "", updatedAt: "", deletedAt: "")
    }
    
    var friends: [User] {
        var friends = [User]()
        for id in 1..<15 {
            friends.append(User(id: id, version: 1, username: "jon", firstName: "Jon", lastName: "Doe", email: "jon@gmail.com", avatar: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80", walletId: 1, wallet: nil, createdAt: "", updatedAt: "", deletedAt: "")
            )
        }
        return friends
    }
    var moneyRequest: MoneyRequest {
        MoneyRequest(id: 7, version: 12, createdAt: "2022-09-06T08:10:56.648Z", updatedAt: "2022-09-06T08:45:06.147Z", deletedAt: nil, title: "[No Test] bro need some 100 bucks", description: "[No Test] I am gonna buy a fresh bike and for the very reason need 100 bucks. Your help will be appreciated.", amount: 5000, status: "pending", requesteeRemark: "yo broke ass f*** Off", requester: User(id: 9, version: 8, username: "test", firstName: "Test", lastName: "TDD", email: "test@gmail.com", avatar: "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTczNDV8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NjE2ODk2NzU&ixlib=rb-1.2.1&q=80&w=1080", walletId: 5, wallet: nil, createdAt: "2022-08-28T12:27:55.307Z", updatedAt: "2022-08-28T12:50:00.462Z", deletedAt: ""), requestee: User(id: 7, version: 1, username: "saurabh", firstName: "Saurabh", lastName: "Bomble", email: "saurabh@gmail.com", avatar: "https://images.unsplash.com/photo-1522778147829-047360bdc7f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTczNDV8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NjE2MzUzODM&ixlib=rb-1.2.1&q=80&w=1080", walletId: 3, wallet: nil, createdAt: "2022-08-27T21:23:03.244Z", updatedAt: "2022-08-27T21:23:03.244Z", deletedAt: ""), requesterId: 9, requesteeId: 7, transactionId: 1)
        
    }
    var friendRequests: [FriendRequestWithRequester] {
        var requests = [FriendRequestWithRequester]()
        for id in 5..<self.friends.count {
            requests.append(FriendRequestWithRequester(id: id, requester: self.friends[id]))
        }
        return requests
    }
    
    var moneyRequests: [MoneyRequest] {
        var requests = [MoneyRequest]()
        
        for id in 1..<15 {
            var request = moneyRequest
            request.id = id
            request.amount = Int.random(in: 1000...1000000)
            requests.append(request)
        }
        return requests
    }
    
    var item: Item {
        Item(id: 33, version: 1, createdAt: "2022-09-04T14:16:25.693Z", updatedAt: "2022-09-04T14:16:25.693Z", deletedAt: nil, name: "americano", description: "not so thick coffee bruhhh", price: 150, image: nil)
    }
    
    var billItem: BillItem {
        BillItem(id: 28, version: 1, createdAt: "2022-09-04T14:16:25.699Z", updatedAt: "2022-09-04T14:16:25.699Z", deletedAt: nil, quantity: 1, total: 150, friends: Array(self.friends[1...3]), item: self.item, billId: 9)
    }
    
    var billItems: [BillItem] {
        var billItems = [BillItem]()
        
        for id in 1...3 {
            var newBillItem = billItem
            newBillItem.id = id
            billItems.append(newBillItem)
        }
        
        return billItems
    }
    
    var bill: Bill {
        Bill(id: 7, version: 4, createdAt: "2022-09-03T11:45:19.791Z", updatedAt: "2022-09-03T11:58:53.473Z", deletedAt: nil, title: "starbucks split", description: "on sunday aditya and test went to starbucks to drink americano coffee and now it's time to pay the split", total: 600, totalWithoutTax: 500, tax: 100, paidAmount: 235, fractionPaid: "0.39", isPaid: false, image: nil, leader: user, friends: friends, billItems: billItems, leaderId: user.id, friendsIds: friends.map {$0.id}, billItemIds: billItems.map{$0.id})
    }
    
    var bills: [Bill] {
        var bills = [Bill]()
        for id in 1...3 {
            var newBill = bill
            newBill.id = id
            newBill.fractionPaid = Double.random(in: 0.12...0.80).getOneDigitString
            bills.append(newBill)
        }
        return bills
    }
    
    var transaction: Transaction {
        Transaction(id: 28, version: 1, createdAt: "2022-10-10T19:45:07.305Z", updatedAt: "2022-10-10T19:45:07.305Z", deletedAt: nil, amount: 400, type: "wallet", isComplete: false, from: user, to: user2, billId: nil, moneyRequestId: 7, bill: nil, moneyRequest: moneyRequest, fromId: 2, toId: 1)
    }
    
    
    var transaction2: Transaction {
        Transaction(id: 28, version: 1, createdAt: "2022-10-10T19:45:07.305Z", updatedAt: "2022-10-10T19:45:07.305Z", deletedAt: nil, amount: 400, type: "split", isComplete: false, from: user, to: user2, billId: bill.id, moneyRequestId: nil, bill: bill, moneyRequest: nil, fromId: 2, toId: 1)
    }
    
    var transactions: [Transaction] {
        var transactions = [Transaction]()
        
        for id in 1...15 {
            var newTransaction = id % 2 == 0 ? transaction : transaction2
            newTransaction.id = id
            transactions.append(newTransaction)
        }
        return transactions
    }
    
    var billItemInput = BillItemInput(billId: 1, name: "americano coffee", description: "it is a beverage brewed from the roasted and ground seeds of the tropical evergreen coffee plant", price: 150, friendIds: [1, 2], quantity: 2)
    
    var billItemInputs: [BillItemInput] {
        [billItemInput, billItemInput, billItemInput, billItemInput, billItemInput, BillItemInput(billId: 4, name: "alsbfa", description: "akjsfkasfvkasfva", price: 130, friendIds: [1,2], quantity: 2)]
    }
}
