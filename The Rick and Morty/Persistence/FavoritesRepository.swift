//
//  FavoritesRepository.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation
import SwiftData

protocol FavoritesRepository {
  func isFavorite(characterID: Int) -> Bool
  func toggleFavorite(characterID: Int)
  
  func isEpisodeSeen(episodeID: Int) -> Bool
  func toggleEpisodeSeen(episodeID: Int)
}

class SwiftDataFavoritesRepository: FavoritesRepository {
  private let context: ModelContext
  
  init(context: ModelContext) {
    self.context = context
  }
  
  func isFavorite(characterID: Int) -> Bool {
    let descriptor = FetchDescriptor<FavoriteCharacter>(
      predicate: #Predicate { $0.characterID == characterID }
    )
    return (try? context.fetch(descriptor).first != nil) ?? false
  }
  
  func toggleFavorite(characterID: Int) {
    let descriptor = FetchDescriptor<FavoriteCharacter>(
      predicate: #Predicate { $0.characterID == characterID }
    )
    if let existing = try? context.fetch(descriptor).first {
      context.delete(existing)
    } else {
      context.insert(FavoriteCharacter(characterID: characterID))
    }
  }
  
  func isEpisodeSeen(episodeID: Int) -> Bool {
    let descriptor = FetchDescriptor<SeenEpisode>(
      predicate: #Predicate { $0.episodeID == episodeID }
    )
    return (try? context.fetch(descriptor).first != nil) ?? false
  }
  
  func toggleEpisodeSeen(episodeID: Int) {
    let descriptor = FetchDescriptor<SeenEpisode>(
      predicate: #Predicate { $0.episodeID == episodeID }
    )
    if let existing = try? context.fetch(descriptor).first {
      context.delete(existing)
    } else {
      context.insert(SeenEpisode(episodeID: episodeID))
    }
  }
}
