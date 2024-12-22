//
//  BudgetingAppApp.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/11/24.
//

import SwiftUI

@main
struct BudgetingAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
