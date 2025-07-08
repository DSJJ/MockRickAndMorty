//
//  EpisodeService.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation

class EpisodeService {
  func fetchEpisodes(from urls: [String]) async throws -> [EpisodeDTO] {
    let ids = urls.compactMap { URL(string: $0)?.lastPathComponent }.joined(separator: ",")
    let url = URL(string: "https://rickandmortyapi.com/api/episode/\(ids)")!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
      throw URLError(.badServerResponse)
    }
    
    if ids.contains(",") {
      return try JSONDecoder().decode([EpisodeDTO].self, from: data)
    } else {
      let single = try JSONDecoder().decode(EpisodeDTO.self, from: data)
      return [single]
    }
  }
}
