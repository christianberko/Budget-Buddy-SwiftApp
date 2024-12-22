//
//  Tabs.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/11/24.
//

import Foundation
import SwiftUI

enum Tab:String{ //tabs for tabView all might not have functionality 
    case recents = "Recents"
    case search = "Search"
   // case charts = "Charts"
    case settings = "Settings"
    
    @ViewBuilder
    var tabContent: some View{
        switch self{
        case .recents:
            Image(systemName: "calendar")
            Text(self.rawValue)
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
//        case .charts:
//            Image(systemName: "chart.bar.xaxis")
//            Text(self.rawValue)
        case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }
    }
    
}


