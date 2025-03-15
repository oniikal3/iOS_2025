//
//  FavoriteManager.swift
//  MoodyMusic
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
            // Delete favorite
            modelContext.delete(favorite)
        } else {
            // Add favorite
            let favorite = FavTrack(trackId: trackId)
            modelContext.insert(favorite)
        }
        
        try? modelContext.save()
    }
    
    func isFavorite(trackId: String) -> Bool {
        let descriptor = FetchDescriptor<FavTrack>(
            predicate: #Predicate<FavTrack> { $0.trackId == trackId }
        )
        
        return (try? modelContext.fetch(descriptor).first) != nil
    }
        
}

