//
//  Transaction.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/16/24.
//

import Foundation

import SwiftUI
import SwiftData


@Model
class Transaction{
//    let id: UUID = .init()
    //creating fields to make a "transaction"
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor ) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    @Transient
    var color: Color{
        return tints.first(where: { $0.color == tintColor})?.value ?? appTint
    }
    @Transient
    var tint: TintColor? {
        return tints.first(where: { $0.color == tintColor}) 
    }
    @Transient
    var rawCategory: Category?{
        return Category.allCases.first(where: {category == $0.rawValue })
    }
}


//sample data for testing the card view but now the app has CRUD

//var sampleData: [Transaction] = [
//    
//    .init(title: "Chipotle", remarks: "Food", amount: 15.50, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
//    .init(title: "Netflix", remarks: "Subscription", amount: 9.99, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
//    .init(title: "Payment", remarks: "Payment Recieved", amount: 2500, dateAdded: .now, category: .income, tintColor: tints.randomElement()!)
//
//
//
//]
