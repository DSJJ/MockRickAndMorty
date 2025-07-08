//
//  MockRickAndMortyService.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation

enum MockError: Error {
  case fakeError
}

struct MockRickAndMortyService: RickAndMortyServiceProtocol {
  let result: Result<CharacterDTO, Error>

  func fetchCharacters(page: Int, name: String, status: String, species: String) async throws -> CharacterDTO {
    try result.get()
  }

  func fetchCharacters(from url: String) async throws -> CharacterDTO {
    try result.get()
  }
}

enum MockData {
  static let page1 = CharacterDTO(
    info: Info(count: 826, pages: 1, next: "https://rickandmortyapi.com/api/character/?page=2", prev: nil),
    results: [
      Character(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male",
                origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""),
                image: "", episode: [], url: "", created: ""),
      Character(id: 2, name: "Morty", status: "Alive", species: "Human", type: "", gender: "Male",
                origin: Origin(name: "Earth", url: ""), location: Location(name: "Earth", url: ""),
                image: "", episode: [], url: "", created: "")
    ]
  )
}
