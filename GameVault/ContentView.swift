//
//  ContentView.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var navigationContext = NavigationContext()
    
    var body: some View {
        GameListView()
            .environment(navigationContext)
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
