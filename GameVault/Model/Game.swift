//
//  Game.swift
//  GameVault
//
//  Created by Alain Ranger on 2025-03-07.
//

import Foundation
import SwiftData

@Model
final class Game: Identifiable {
    @Attribute(.unique) var id: String = UUID().uuidString
    var title: String = ""
    var platform: String = ""
    var genre: String = ""
    var rating: Int? = nil
    var releaseDate: Date? = nil
    var completionDate: Date? = nil
    var playTime: Int
    var status: String = ""
    var notes: String = ""
    
    init(title: String = "", platform: String = "", genre: String = "", rating: Int? = nil, releaseDate: Date? = nil, completionDate: Date? = nil, playTime: Int = 0, status: String = "", notes: String = "") {
        self.title = title
        self.platform = platform
        self.genre = genre
        self.rating = rating
        self.releaseDate = releaseDate
        self.completionDate = completionDate
        self.playTime = playTime
        self.status = status
        self.notes = notes
    }
}
