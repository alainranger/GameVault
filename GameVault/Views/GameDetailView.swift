//
//  GameDetailView.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-07.
//

import SwiftUI
import SwiftData

struct GameDetailView: View {
    
    var game: Game?
    
    @State private var isEditing = false
    @State private var isDeleting = false
    
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationContext.self) private var navigationContext
    
    var body: some View {
        if let game {
            List {
                HStack {
                    Text("Title")
                    Spacer()
                    Text("\(game.title)")
                }
                HStack {
                    Text("Platofrm")
                    Spacer()
                    Text("\(game.platform)")
                }
                HStack {
                    Text("Release date")
                    Spacer()
                    Text(game.releaseDate.map { "\($0, style: .date)" } ?? "")
                }
                HStack {
                    Text("Genre")
                    Spacer()
                    Text("\(game.genre)")
                }
                HStack {
                    Text("Rating")
                    Spacer()                    
                    Text(game.rating.map { "\($0)" } ?? "")
                }
                HStack {
                    Text("Completion Date")
                    Spacer()
                    Text(game.completionDate.map { "\($0, style: .date)" } ?? "")
                }
                HStack {
                    Text("Play Time")
                    Spacer()
                    Text("\(game.playTime)")
                }
                HStack {
                    Text("Status")
                    Spacer()
                    Text("\(game.status)")
                }
                HStack {
                    Text("Notes")
                    Spacer()
                    Text("\(game.notes)")
                }
            }
            
        } else {
            ContentUnavailableView("No game", systemImage: "")
        }
        
    }
    
    private func delete(_ game: Game) {
        navigationContext.selectedGame = nil
        modelContext.delete(game)
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        GameDetailView(game: .game1)
            .environment(NavigationContext())
    }
}

/*
 
 TextField("Title", text: $title)
 TextField("Platform", text: $platform)
 DatePicker("Release Date", selection: $releaseDate, displayedComponents: .date)
 TextField("Genre", text: $genre)
 Stepper("Rating: \(rating)", value: $rating, in: 0...5)
 DatePicker("Completion Date", selection: $completionDate, displayedComponents: .date)
 Stepper("Play Time: \(playTime)", value: $playTime, in: 0...100)
 TextField("Status", text: $status)
 Label("Notes", systemImage: "pencil")   // TextEditor not available in preview
 TextEditor(text: $notes)
 
 */
