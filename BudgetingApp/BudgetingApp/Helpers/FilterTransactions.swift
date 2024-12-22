//
//  FilterTransactions.swift
//  BudgetingApp
//
//  Created by gccisadmin on 5/4/24.
//

import SwiftUI
import SwiftData
struct FilterTransactions<Content: View>: View {  //filtering search text  got this straight from youTube
    
    var content: ([Transaction]) -> Content
    @Query(animation: .snappy) private var transactions: [Transaction]
    
    init(category: Category? ,searchText:String, @ViewBuilder content: @escaping ([Transaction]) -> Content ){
        
        let rawValue = category?.rawValue ?? ""
        let searchThing = #Predicate<Transaction>{ transaction in
            return transaction.title.localizedStandardContains(searchText) ||
            transaction.remarks.localizedStandardContains(searchText) && (rawValue.isEmpty ? true: transaction.category == rawValue)
        }
        
        _transactions = Query(filter: searchThing, sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy)
        
        self.content = content
        
    }
    
    var body: some View {
        content(transactions)
    }
}


