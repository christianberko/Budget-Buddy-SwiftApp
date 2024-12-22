//
//  Setting.swift
//  BudgetingApp
//
//  Created by gccisadmin on 4/16/24.
//

import SwiftUI

struct Setting: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false //dark mode var to change entire application
    var body: some View {
        NavigationView{
            VStack{
                
                Toggle("Dark Mode", isOn: $isDarkMode) //toggle switch 
                    .padding(20)
                    
//                Text("Hello, World!")
//                    .foregroundColor(isDarkMode ? .white : .black)
//                    .background(isDarkMode ? Color.black : Color.white)
                
                
                Spacer()
            }
            .preferredColorScheme(isDarkMode ? .dark: .light).padding(.bottom, 20)
            .navigationTitle(Text("Settings"))
        }
        
        
    }
}

#Preview {
    Setting()
}
