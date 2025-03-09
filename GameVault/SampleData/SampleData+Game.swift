//
//  SampleData+Game.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-08.
//

import Foundation
import SwiftData

extension Game {
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    
    static let game1 = Game(title: "Game1",
                                platform: "PC",
                                releaseDate: dateFormatter.date(from: "2024-01-10"))
        
        static let game2 = Game(title: "Game2",
                                platform: "PS5")
        
        static let game3 = Game(title: "Game3",
                                platform: "Xbox",
                                releaseDate: dateFormatter.date(from: "2022-09-15"))
        
        static let game4 = Game(title: "Game4",                                
                                releaseDate: dateFormatter.date(from: "2021-12-05"))
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(Game.game1)
        modelContext.insert(Game.game2)
        modelContext.insert(Game.game3)
        modelContext.insert(Game.game4)
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Game.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
