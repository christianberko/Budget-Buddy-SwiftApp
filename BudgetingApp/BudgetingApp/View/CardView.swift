//
//  CardView.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/30/24.
//

import SwiftUI

struct CardView: View {
    //displays expenese and income in a card at the top of the recents screen
    var income: Double
    var expenses: Double
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            VStack(spacing:0){
                HStack(spacing:12){
                    Text("\(currencyString(income - expenses))") //calculating income/ expense
                        .font(.title.bold())
                    
                    Image(systemName: expenses > income ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis")
                        .font(.title3)
                        .foregroundStyle(expenses > income ? .red: .green) //chaing the icon
                    
                }
                .padding(.bottom, 25)
                HStack(spacing: 0){
                    ForEach(Category.allCases, id: \.rawValue){ category in
                        let symbol = category == .income ? "arrow.down" : "arrow.up" //flair
                        let tint = category == .income ? Color.red: Color.green //changing tint based of the expense or income
                        HStack(spacing:10){
                            Image(systemName: symbol)
                                .font(.callout.bold())
                                .foregroundStyle(tint)
                                .frame(width:25, height:35)
                                .background{
                                    Circle()
                                        .fill(tint.opacity(0.25).gradient)
                                    
                                }
                            VStack(alignment:.leading, spacing:4){
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                Text(currencyString(category ==  .income ? income: expenses, allowedDigits:0))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                            
//                            if category == .income{
//                                Spacer(minLength: 10)
//                            }
                        }
                    }
                }
            }
            .padding([.top, .bottom], 15)
        }
    }
}

#Preview {
    CardView(income: 700, expenses: 500)
}
