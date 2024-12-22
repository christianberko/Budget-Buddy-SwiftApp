//
//  TintColor.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/30/24.
//

import Foundation
import SwiftUI

struct TintColor: Identifiable{ //creating tint color so I can easily use it throughtout the UI
    let id: UUID = .init()
    var color: String
    var value: Color
    
    
}

var tints :[TintColor] = [ //setting up the colors I want to se 
    .init(color: "Red" ,value: .red ),
    .init(color: "Blue" ,value: .blue ),
    .init(color: "Pink" ,value: .pink ),
    .init(color: "Purple" ,value: .purple ),
    .init(color: "Orange" ,value: .orange )
    



]
