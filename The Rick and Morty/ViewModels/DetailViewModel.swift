//
//  DetailViewModel.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class DetailViewModel: ObservableObject {
  @Published var episodes: [EpisodeDTO] = []
  @Published var isFavorite = false
  @Published var seenEpisodeIDs: Set<Int> = []
  
  private let repository: FavoritesRepository
  
  init(repository: FavoritesRepository) {
    self.repository = repository
  }
  
  func load(characterID: Int, episodeURLs: [String]) async {
    isFavorite = repository.isFavorite(characterID: characterID)
    do {
      let result = try await EpisodeService().fetchEpisodes(from: episodeURLs)
      self.episodes = result.sorted { $0.episode < $1.episode }
      self.seenEpisodeIDs = Set(result.compactMap { episode in
        repository.isEpisodeSeen(episodeID: episode.id) ? episode.id : nil
      })
    } catch {
      print("Error cargando episodios: \(error)")
    }
  }
  
  func toggleFavorite(characterID: Int) {
    repository.toggleFavorite(characterID: characterID)
    isFavorite.toggle()
  }
  
  func toggleEpisodeSeen(_ id: Int) {
    repository.toggleEpisodeSeen(episodeID: id)
    if seenEpisodeIDs.contains(id) {
      seenEpisodeIDs.remove(id)
    } else {
      seenEpisodeIDs.insert(id)
    }
  }
}
