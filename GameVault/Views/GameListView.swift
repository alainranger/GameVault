//
//  GameListView.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-07.
//

import SwiftUI
import SwiftData

struct GameListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext

    @Query var games: [Game]
    
    @State private var isEditorPresented = false
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        
        List(selection: $navigationContext.selectedGame) {
            ForEach(games) { game in
                NavigationLink {
                    GameDetailView(game: game)
                } label: {
                    GameRow(game: game)
                }
            }
            .onDelete(perform: removeGames)
        }
        .sheet(isPresented: $isEditorPresented) {
            GameEditorView(game: nil)
        }
        .overlay {
            if games.isEmpty {
                ContentUnavailableView {
                    Text("No games")
                } description: {
                    AddGameButton(isActive: $isEditorPresented)
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddGameButton(isActive: $isEditorPresented)
            }
        }
    }
    
    private func removeGames(at indexSet: IndexSet) {
        for index in indexSet {
            let gamesToDelete = games[index]
            if navigationContext.selectedGame?.persistentModelID == gamesToDelete.persistentModelID {
                navigationContext.selectedGame = nil
            }
            modelContext.delete(gamesToDelete)
        }
    }
}

private struct AddGameButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add a game", systemImage: "plus")
                .help("Add a game")
        }
    }
}

#Preview("GameListView") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            GameListView()
                .environment(NavigationContext())
        }
    }
}

#Preview("No games") {
    GameListView()
        .environment(NavigationContext())
}

#Preview("AddGameButton") {
    AddGameButton(isActive: .constant(false))
}
