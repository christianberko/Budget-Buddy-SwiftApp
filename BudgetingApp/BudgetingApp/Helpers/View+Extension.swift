//
//  View+Extension.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/16/24.
//

import Foundation
import SwiftUI

extension View{
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View{ // extracts reusable alignment properties
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vSpacing(_ alignment: Alignment = .center) -> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    var safeArea: UIEdgeInsets{
        if let windowScene =  (UIApplication.shared
            .connectedScenes.first as? UIWindowScene){
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }
    
    
    func format(date:Date, format:String) -> String{ //formats date for cardView
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func currencyString(_ value: Double, allowedDigits: Int = 2 ) ->String{  //format $$ for cardView 
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = allowedDigits
        return formatter.string(from: .init(value: value)) ?? ""
    }
}
