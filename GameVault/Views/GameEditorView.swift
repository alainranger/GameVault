//
//  AddGameItemView.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-08.
//

import SwiftUI
import SwiftData

private struct GameEditorViewModel {
    var title = ""
    var platform = ""
    var releaseDate = Date()
    var genre = ""
    var rating = 0
    var completionDate = Date()
    var playTime = 0
    var status = ""
    var notes = ""
}

struct GameEditorView: View {
    
    let game: Game?
    
    @State private var viewModel = GameEditorViewModel(title: "", platform: "", releaseDate: Date(), genre: "", rating: 0, completionDate: Date(), playTime: 0, status: "", notes: "")
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    private var editorTitle: String {
        game == nil ? "Add Game" : "Edit Game"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $viewModel.title)
                TextField("Platform", text: $viewModel.platform)
                DatePicker("Release Date", selection: $viewModel.releaseDate, displayedComponents: .date)
                TextField("Genre", text: $viewModel.genre)
                Stepper("Rating: \(viewModel.rating)", value: $viewModel.rating, in: 0...5)
                DatePicker("Completion Date", selection: $viewModel.completionDate, displayedComponents: .date)
                Stepper("Play Time: \(viewModel.playTime)", value: $viewModel.playTime, in: 0...100)
                TextField("Status", text: $viewModel.status)
                Label("Notes", systemImage: "pencil")   // TextEditor not available in preview
                TextEditor(text: $viewModel.notes)
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
                    .disabled(viewModel.title.isEmpty)
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
                    viewModel.title = game.title
                    viewModel.platform = game.platform
                    // TODO if date is nil, set no date
                    viewModel.releaseDate = game.releaseDate ?? Date()
                    viewModel.genre = game.genre
                    viewModel.rating = game.rating ?? 0
                    // TODO if date is nil, set no date
                    viewModel.completionDate = game.completionDate ?? Date()
                    viewModel.playTime = game.playTime
                    viewModel.status = game.status
                    viewModel.notes = game.notes
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
            game.title = viewModel.title
            game.platform = viewModel.platform
            game.releaseDate = viewModel.releaseDate
            game.genre = viewModel.genre
            game.rating = viewModel.rating
            game.completionDate = viewModel.completionDate
            game.playTime = viewModel.playTime
            game.status = viewModel.status
            game.notes = viewModel.notes
        } else {
            // Add a game
            let newGame = Game(title: viewModel.title)
            newGame.platform = viewModel.platform
            newGame.releaseDate = viewModel.releaseDate
            newGame.genre = viewModel.genre
            newGame.rating = viewModel.rating
            newGame.completionDate = viewModel.completionDate
            newGame.playTime = viewModel.playTime
            newGame.status = viewModel.status
            newGame.notes = viewModel.notes
            
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
