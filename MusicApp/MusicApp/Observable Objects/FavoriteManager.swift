//
//  FavoriteManager.swift
//  MusicApp
//
//  Created by Nathapong Masathien on 15/3/25.
//

import Foundation
import SwiftData

@Model
class FavTrack {
    @Attribute(.unique) var trackId: String
    var dateAdded: Date
    
    init(trackId: String) {
        self.trackId = trackId
        self.dateAdded = Date()
    }
}

@Observable
class FavoriteManager {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func toggleFavorite(trackId: String) {
        let descriptor = FetchDescriptor<FavTrack>(
            predicate: #Predicate<FavTrack> { $0.trackId == trackId }
        )
        
        if let favorite = try? modelContext.fetch(descriptor).first {
            modelContext.delete(favorite)
        } else {
            let favorite = FavTrack(trackId: trackId)
            modelContext.insert(favorite)
        }
        try? modelContext.save()
    }
    
    func isFavorite(trackId: String) -> Bool {
        let descriptor = FetchDescriptor<FavTrack>( // FetchDescriptor is a query builder
            predicate: #Predicate<FavTrack> { $0.trackId == trackId } // Predicate is a condition builder
        )
        
        return (try? modelContext.fetch(descriptor).first) != nil
    }
}
