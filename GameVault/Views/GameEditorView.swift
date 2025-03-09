//
//  AddGameItemView.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-08.
//

import SwiftUI
import SwiftData

struct GameEditorView: View {
    
    let game: Game?
    
    @State private var title = ""
    @State private var platform = ""
    @State private var releaseDate = Date()
    @State private var genre = ""
    @State private var rating = 0
    @State private var completionDate = Date()
    @State private var playTime = 0
    @State private var status = ""
    @State private var notes = ""
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    private var editorTitle: String {
        game == nil ? "Add Game" : "Edit Game"
    }
    
    var body: some View {
        NavigationStack {
            Form {
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
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    // Require a title to save changes.
                    .disabled(title.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let game {
                    // Edit the incoming animal.
                    title = game.title
                    platform = game.platform
                    // TODO if date is nil, set no date
                    releaseDate = game.releaseDate ?? Date()
                    genre = game.genre
                    rating = game.rating ?? 0
                    // TODO if date is nil, set no date
                    completionDate = game.completionDate ?? Date()
                    playTime = game.playTime
                    status = game.status
                    notes = game.notes
                }
            }
            #if os(macOS)
            .padding()
            #endif
        }
    }
    
    private func save() {
        if let game {
            // Edit the game
            game.title = title
            game.platform = platform
            game.releaseDate = releaseDate
            game.genre = genre
            game.rating = rating
            game.completionDate = completionDate
            game.playTime = playTime
            game.status = status
            game.notes = notes
        } else {
            // Add a game
            let newGame = Game(title: title)
            newGame.platform = platform
            newGame.releaseDate = releaseDate
            newGame.genre = genre
            newGame.rating = rating
            newGame.completionDate = completionDate
            newGame.playTime = playTime
            newGame.status = status
            newGame.notes = notes
            
            modelContext.insert(newGame)
        }
    }
}

#Preview("Edit Game") {
    ModelContainerPreview(ModelContainer.sample) {
        GameEditorView(game: .game1)
    }
}

#Preview("Add Game") {
    ModelContainerPreview(ModelContainer.sample) {
        GameEditorView(game: nil)
    }
}
