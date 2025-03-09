//
//  GameRow.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-08.
//

import SwiftUI
import SwiftData

struct GameRow: View {
    let game: Game
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(game.title)
                .font(.title)
            Text(game.platform)
                .font(.subheadline)
            Text(game.releaseDate.map { "Release: \($0, style: .date)" } ?? "")
                .font(.subheadline)
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        GameRow(game: .game1)
    }
}
