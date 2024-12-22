//
//  SwiftUIView.swift
//  BudgetingApp
//
//  Created by gccisadmin on 5/1/24.
//

import SwiftUI

struct TransactionCardView: View {
    //card for the actual transactions to view
    @Environment (\.modelContext) private var context //environement var
    
    //@State private var deleteTrctn = false
    var transaction:Transaction
    var body: some View {
        
        HStack(spacing:12){ //creating card  
            Text("\(String(transaction.title.prefix(1)))") //having the first letter of the item displayed in a circle
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: 45, height: 45, alignment: .center)
                .background(transaction.color.gradient, in:.circle)
            
            VStack(alignment: .leading, spacing: 4, content: { //input fields 
                Text(transaction.title)
                    .foregroundStyle(Color.primary)
                Text(transaction.remarks)
                    .font(.caption)
                    .foregroundStyle(Color.primary.secondary)
                
                Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                    .font(.caption2)
                    .foregroundStyle(.gray)
            })
            .lineLimit(1)
            .hSpacing(.leading)
            
            Text(currencyString(transaction.amount, allowedDigits: 2))
                .fontWeight(.semibold)
            
        }
        
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.background, in:.rect(cornerRadius: 10)) //creating size 
        
    }
    
    
    
    
}

#Preview {
    ContentView()
}
