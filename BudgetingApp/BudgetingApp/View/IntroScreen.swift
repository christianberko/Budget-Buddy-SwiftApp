//
//  IntroScreen.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/11/24.
//

import SwiftUI

struct IntroScreen: View { //View was created for the first time users open the app so that they can see the features of it first before usage
    //Visibility
    
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    var body: some View {
        VStack(spacing:15){
            Text("What is new in the\nExpense Tracker")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top,65)
                .padding(.bottom, 35)
            VStack(alignment: .leading, spacing: 25, content: {
                PointView(symbol: "dollarsign", title: "Transactions", subTitle: "Keep track of your earning and expenses.")
                
//                PointView(symbol: "chart.bar.fill", title: "Visual Charts", subTitle: "View your transactions using eye-catching graphical representation.")
                
                PointView(symbol: "magnifyingglass", title: "Advanced Filters", subTitle: "Find the expenses you want through advanced filtering")
                
                
                
                
            }) //VStack
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            Spacer(minLength: 10)
            
            Button(action:{
                isFirstTime = false
            }, label:{
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth:.infinity)
                    .padding(.vertical, 14)
                    .background(appTint.gradient, in: .rect(cornerRadius: 12)) //when pressed the view is pushed way and you are left with the TabView
            })
        } //First Vstack
        .padding(15)
    }
    
    @ViewBuilder
    func PointView(symbol:String, title:String, subTitle:String) ->some View{
        HStack(spacing:20){
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing:6, content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(subTitle)
                    .foregroundStyle(.gray)
            })
        }
    }
}

#Preview {
    IntroScreen()
}
