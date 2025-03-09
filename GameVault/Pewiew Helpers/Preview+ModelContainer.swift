//
//  PreviewSampleData.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-08.
//

import Foundation
import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([Game.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            Game.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
