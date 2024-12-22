//
//  Search.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/16/24.
//

import SwiftUI
import Combine
// search struct got this straight from youTube
struct Search: View { //view to search thru transactions
    //View Properties
    let search = PassthroughSubject<String, Never>()
    @State private var searchText :String = ""
    @State private var filterText: String = ""
    @State private var selectedCatgory: Category? = nil
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                LazyVStack(spacing: 12){
                    FilterTransactions(category: selectedCatgory, searchText: filterText){ transactions in
                        ForEach(transactions){ transaction in
                            NavigationLink{
                                NewExpenseView(editTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction)
                            }
                            .buttonStyle(.plain)
                            .padding(10)
                        }
                    }
                }
                
            }
            .overlay(content:{
                ContentUnavailableView("Search Transactions", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1: 0)
            })
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty{
                   filterText = ""
                }
                search.send(newValue)
            }).onReceive(search.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
                //print(text) To test if the search was getting the search text 
            })
            .searchable(text: $searchText)
            .navigationTitle("Search ")
            .background(.gray.opacity(0.15))
        }
    }
}

#Preview {
    Search()
}
