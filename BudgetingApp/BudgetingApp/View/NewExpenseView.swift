//
//  NewExpenseView.swift
//  BudgetingApp
//
//  Created by gccisadmin on 5/3/24.
//

import SwiftUI

struct NewExpenseView: View { //this struct is for creating new transaction
    //View Properties
    @Environment (\.modelContext) private var context
    @Environment (\.dismiss) private var dismiss
    
    var editTransaction: Transaction?
    
    @State private var title: String = ""
    @State private var remarks:String = ""
    @State private var amount:  Double = .zero
    @State private var dateAdded:Date = .now
    @State private var category:Category = .expense
    //Random tint for the color
    @State var randTint: TintColor = tints.randomElement()! //random color for each transaction
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing:20){
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                TransactionCardView(transaction: .init(title: title.isEmpty ? "Title": title, remarks: remarks.isEmpty ? "Remarks": remarks , amount: amount, dateAdded: dateAdded, category: category, tintColor:randTint))  //Preview of what the card will look like for the user.. updates as the  user inputs information
                
                InputFields("Title", "Playstation 5" , value: $title) //input fields w/default text to help users 
                
                InputFields("Title", "Present for Brother" , value: $remarks) // input fields
                
                
                VStack(alignment: .leading, content: {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing:15){
                        TextField("0.0" , value:$amount, formatter: numberFormatter)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                            .background(.background, in: .rect(cornerRadius: 10))
                            .frame(maxWidth: 130)
                            .keyboardType(.decimalPad)
                        
                        CheckBox()                    } //picker whether the transaction is income or expense
                })
                
                //Date Picker
                VStack(alignment: .leading, content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date]) //building large datepicker
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                })
                
                
                
                
                
            }
            .padding(15)
        }
        .navigationTitle("\(editTransaction == nil ? "Add" : "Edit") Transaction") //changes the title of the view so that when the card is being edited the title changes from add -> edit
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing){
                Button("Save", action: save) //save button to save the data and pass it to the recents view
                
               
    
            }
        })
        .onAppear(perform: {
            //when the transaction is clicked after being saved the edit view is invoked but it has to have the data of the current transaction s
            if let editTransaction{
                //load all existing data from selected transaction
                title = editTransaction.title
                remarks = editTransaction.remarks
                dateAdded = editTransaction.dateAdded
                if let category  = editTransaction.rawCategory{
                    self.category = category
                }
               
                amount = editTransaction.amount
                if let tint =  editTransaction.tint{
                    self.randTint = tint
                }
               
            }
        })
        
        
    }
    
    func save(){  //saving the data to the model
        if editTransaction != nil{
            editTransaction?.title = title
            editTransaction?.remarks = remarks
            editTransaction?.amount = amount
            editTransaction?.category = category.rawValue
            editTransaction?.dateAdded = dateAdded
        } else{
            //Saving the data
            let transaction = Transaction(title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category, tintColor: randTint)
            
            context.insert(transaction)
        }
        
        dismiss()
    }
    
    @ViewBuilder
    func InputFields(_ title: String,_ hint:String, value: Binding<String>) -> some View{ //extracting the input fields
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        })
    }
    
    @ViewBuilder
    func CheckBox() -> some View{  //extraction of checkbox
        HStack(spacing:10){
            ForEach(Category.allCases, id: \.rawValue){ category in
                HStack(spacing: 5){
                    ZStack{
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.category == category{
                            Image(systemName: "circle.fill")
                                .font(.title3)
                                .foregroundStyle(appTint)
                        }
                    }
                    Text(category.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
                
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    
    var numberFormatter: NumberFormatter{  //formatting the number for the transaction card
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    NavigationStack{
        NewExpenseView()
    }
    
}
