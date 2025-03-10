//
//  AddGameItemView.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-08.
//

import SwiftUI
import SwiftData

private struct GameEditorViewModel {
    var title: String
    var platform: String?
    var releaseDate: Date?
    var genre: String?
    var rating: Int?
    var completionDate: Date?
    var playTime: Int?
    var status: String?
    var notes: String?
}

struct GameEditorView: View {
    
    let game: Game?
    
    @State private var viewModel = GameEditorViewModel(title: "", platform: "", releaseDate: Date(), genre: "", rating: 0, completionDate: Date(), playTime: 0, status: "", notes: "")
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    private var editorTitle: String {
        game == nil ? "Add Game" : "Edit Game"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $viewModel.title)
                TextField("Platform", text: Binding(
                    get: { viewModel.platform ?? "" },
                    set: { viewModel.platform = $0.isEmpty ? nil : $0 }
                ))
                
                VStack {
                    if let releaseDate = viewModel.releaseDate {
                        Text("Selected Date: \(dateFormatter.string(from: releaseDate))")
                    } else {
                        Text("Release Date: Not Set")
                    }

                    DatePicker("Select Date", selection: Binding(
                        get: { viewModel.releaseDate ?? Date() },
                        set: { viewModel.releaseDate = $0 }
                    ), displayedComponents: [.date])

                    Button("Clear Date") {
                        viewModel.releaseDate = nil
                    }
                }
                .padding()
                
                //DatePicker("Release Date", selection: $viewModel.releaseDate, displayedComponents: .date)
                TextField("Genre", text: Binding (
                    get: { viewModel.genre ?? "" },
                    set: { viewModel.genre = $0.isEmpty ? nil : $0 }
                ))
                
                VStack {
                    Text("Play Time: \(viewModel.rating.map { "\($0) hours" } ?? "Not set")")

                    Stepper("Hours", value: Binding(
                        get: { viewModel.rating ?? 0 }, // Si nil, retourne 0
                        set: { viewModel.rating = $0 }  // Met à jour la valeur
                    ), in: 0...100)

                    Button("Clear Play Time") {
                        viewModel.rating = nil // Réinitialise à nil
                    }
                }
                .padding()
                // Stepper("Rating: \(viewModel.rating)", value: $viewModel.rating, in: 0...5)
                
                
                VStack {
                    if let completionDate = viewModel.completionDate {
                        Text("Selected Date: \(dateFormatter.string(from: completionDate))")
                    } else {
                        Text("Completion Date: Not Set")
                    }

                    DatePicker("Select Date", selection: Binding(
                        get: { viewModel.completionDate ?? Date() },
                        set: { viewModel.completionDate = $0 }
                    ), displayedComponents: [.date])

                    Button("Clear Date") {
                        viewModel.completionDate = nil
                    }
                }
                .padding()
                
                
                // DatePicker("Completion Date", selection: $viewModel.completionDate, displayedComponents: .date)
                
                VStack {
                    Text("Play Time: \(viewModel.playTime.map { "\($0) hours" } ?? "Not set")")

                    Stepper("Hours", value: Binding(
                        get: { viewModel.playTime ?? 0 }, // Si nil, retourne 0
                        set: { viewModel.playTime = $0 }  // Met à jour la valeur
                    ), in: 0...100)

                    Button("Clear Play Time") {
                        viewModel.playTime = nil // Réinitialise à nil
                    }
                }
                .padding()
                
                //Stepper("Play Time: \(viewModel.playTime)", value: $viewModel.playTime, in: 0...100)
                TextField("Status", text: Binding (
                    get: { viewModel.status ?? "" },
                    set: { viewModel.status = $0.isEmpty ? nil : $0 }
                ))
                
                Label("Notes", systemImage: "pencil")   // TextEditor not available in preview
                TextEditor(text: Binding (
                    get: { viewModel.notes ?? "" },
                    set: { viewModel.notes = $0.isEmpty ? nil : $0 }
                ))
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
