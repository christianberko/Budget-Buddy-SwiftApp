//
//  ContentView.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true //is it the users fist time using the app
    
    @State private var activeTab: Tab = .recents
    var body: some View {
        TabView(selection: $activeTab)  {
            Recents()
                .tag(Tab.recents)
                .tabItem { Tab.recents.tabContent }
            
            Search()
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
            
//            Text("Charts")
//                .tag(Tab.charts)
//                .tabItem { Tab.charts.tabContent }
            
            Setting()
                .tag(Tab.settings)
                .tabItem { Tab.settings.tabContent }
        }
        .sheet(isPresented: $isFirstTime, content: {
            IntroScreen()
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    ContentView()
}
