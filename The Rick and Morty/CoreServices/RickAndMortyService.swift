//
//  RickAndMortyService.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation

protocol RickAndMortyServiceProtocol {
  func fetchCharacters(page: Int, name: String, status: String, species: String) async throws -> CharacterDTO
  func fetchCharacters(from urlString: String) async throws -> CharacterDTO
}

class RickAndMortyService: RickAndMortyServiceProtocol {
  private let baseURL = URL(string: "https://rickandmortyapi.com/api/character")!
  
  func fetchCharacters(page: Int = 1, name: String = "", status: String = "", species: String = "") async throws -> CharacterDTO {
    var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!
    var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
    
    if !name.isEmpty { queryItems.append(URLQueryItem(name: "name", value: name)) }
    if !status.isEmpty { queryItems.append(URLQueryItem(name: "status", value: status)) }
    if !species.isEmpty { queryItems.append(URLQueryItem(name: "species", value: species)) }
    
    components.queryItems = queryItems
    let url = components.url!
    return try await fetch(from: url)
  }
  
  func fetchCharacters(from urlString: String) async throws -> CharacterDTO {
    guard let url = URL(string: urlString) else {
      throw URLError(.badURL)
    }
    return try await fetch(from: url)
  }
  
  private func fetch(from url: URL) async throws -> CharacterDTO {
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
      throw URLError(.badServerResponse)
    }
    
    return try JSONDecoder().decode(CharacterDTO.self, from: data)
  }
}
