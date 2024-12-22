//
//  Recents.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/16/24.
//

import SwiftUI
import SwiftData


struct Recents: View {
    @AppStorage("userName") private var userName:String = "" //this isnt used rly 
    @Environment (\.modelContext) private var context
    @Environment (\.dismiss) private var dismiss
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate:Date = .now.endOfMonth
   // @State private var deleteTrctn = false
    
    @State private var selectedCategory: Category = .expense //for the picker to select
    
  
    
    @Query(sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy) private var transactions: [Transaction] //reading in the data
    
   
    
    var totalIncome: Double { //calculates all income transactions in the array to be passed into the cardView
           return transactions.reduce(0) { result, transaction in
               if transaction.category == Category.income.rawValue {
                   return result + transaction.amount
               }
               return result
           }
       }

    var totalExpenses: Double {  //calculates all expenses  transactions in the array to be passed into the cardView
            return transactions.reduce(0) { result, transaction in
                if transaction.category == Category.expense.rawValue {
                    return result + transaction.amount
                }
                return result
            }
        }
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            NavigationStack{
                ScrollView(.vertical){
                    LazyVStack(spacing:10, pinnedViews: [.sectionHeaders]){
                        Section{
                            //Date Filter
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { //shows current date till end of the current month
                                Text("\(format(date:startDate, format: "dd - MMM yy")) to \(format(date:endDate, format: "dd - MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            })
                            .hSpacing(.leading)
                            
                            
                            CardView(income: totalIncome, expenses: totalExpenses) //card view
                            
                            //Picker for expenses or income
//                            customPicker()  
                            Picker( selection: $selectedCategory, label: EmptyView()){ //picker to show just expenses or just income
                                Text("Income").tag(0)
                                Text("Expenses").tag(1)
                                
                            }
                            .pickerStyle(.segmented)
                            
                            
                            ForEach(transactions){ transaction in //transaction cards
                                NavigationLink{
                                    NewExpenseView(editTransaction: transaction) //when the transaction card is pressed it opens the edit transaction view
                                    
                                } label: {
                                    TransactionCardView(transaction: transaction)
                                        //delete functionality but when implemeted update does not work (fixing..)
//                                    .onLongPressGesture(perform: {
//                                        
//                                        deleteTrctn = true
//                                        
//                                    }).alert(isPresented: $deleteTrctn){
//                                        let transactionToDelete = transaction
//                                        
//                                        return Alert(
//                                            title: Text("Delete Transaction"),
//                                            message: Text("This will delete the entry"),
//                                            primaryButton: .destructive(Text("Delete")){
//                                                context.delete(transactionToDelete)
//                                            },
//                                            secondaryButton: .cancel(Text("Cancel"))
//                                        )
//                                        
//                                    
//                                    }
                                       
                                }
                                .buttonStyle(.plain)
                            }
                            
                           // Text("Total Income: \(totalIncome)")
                            
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
            }
        }
    }
    
    @ViewBuilder
    func HeaderView(_ size:CGSize) ->some View{ //style for header (extraction)
        HStack (spacing:10 ){
            VStack(alignment: .leading, spacing:5 ,content: {
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty{
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            })
            
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor:.topLeading) //scales when u swipe on the whole page
            }
            .hSpacing(.leading)
            .overlay(alignment: .trailing, content: {
                NavigationLink{
                   NewExpenseView()
                
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .background(appTint.gradient, in: .circle)
                        .contentShape(.circle)
                }
            })
            
            .padding(.bottom,5)
            .background{
                VStack (spacing:0){
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .padding(.horizontal, -15)
                    .padding(.top, -(safeArea.top + 15))
                    
                    Divider() 
                }.visualEffect { content, geometryProxy in
                    content
                }
            }
        }
    }
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat{ //scale for header 
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = (min(max(progress,0), 1) * 0.3)
        return 1 + scale
        
    }
    
//    @ViewBuilder
//    func customPicker() -> some View{
//        HStack(spacing: 0){
//            ForEach(Category.allCases, id: \.rawValue){category in
//                Text(category.rawValue)
//                    .hSpacing()
//                    .padding(.vertical, 10)
//                    .background{
//                        if category == selectedCategory{
//                            Capsule()
//                                .fill(.background)
//                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
//                        }
//                    }
//            }
//        }
//    }
}

#Preview {
    ContentView()
}
