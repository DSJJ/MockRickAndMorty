//
//  The_Rick_and_MortyTests.swift
//  The Rick and MortyTests
//
//  Created by David Jiménez  on 08/07/25.
//

import Testing
@testable import The_Rick_and_Morty

struct The_Rick_and_MortyTests {
  
  struct MockRickAndMortyService: RickAndMortyServiceProtocol {
    let result: Result<CharacterDTO, Error>
    
    func fetchCharacters(page: Int, name: String, status: String, species: String) async throws -> CharacterDTO {
      try result.get()
    }
    
    func fetchCharacters(from url: String) async throws -> CharacterDTO {
      try result.get()
    }
  }
  
  enum MockError: Error, Equatable {
    case failed
  }
  
  struct MockData {
    static let character = Character(
      id: 1,
      name: "Rick Sanchez",
      status: "Alive",
      species: "Human",
      type: "",
      gender: "Male",
      origin: Origin(name: "Earth", url: ""),
      location: Location(name: "Citadel of Ricks", url: ""),
      image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      episode: [],
      url: "",
      created: ""
    )
    
    static let page1 = CharacterDTO(
      info: Info(count: 826, pages: 1, next: "https://rickandmortyapi.com/api/character/?page=2", prev: nil),
      results: [character]
    )
  }
  
  @Test func testLoadInitialSuccess() async throws {
    let mockService = MockRickAndMortyService(result: .success(MockData.page1))
    let viewModel = await CharactersViewModel(service: mockService)
    
    await viewModel.loadInitial()
    
    await #expect(viewModel.characters.count == 1)
    await #expect(viewModel.characters.first?.name == "Rick Sanchez")
    await #expect(viewModel.hasError == false)
    await #expect(viewModel.errorMessage == nil)
    await #expect(viewModel.nextPageURL == "https://rickandmortyapi.com/api/character/?page=2")
  }
  
  @Test func testLoadInitialFailure() async throws {
    let mockService = MockRickAndMortyService(result: .failure(MockError.failed))
    let viewModel = await CharactersViewModel(service: mockService)
    
    await viewModel.loadInitial()
    
    await #expect(viewModel.characters.isEmpty)
    await #expect(viewModel.hasError == true)
    await #expect(viewModel.errorMessage != nil)
  }
  
  @Test func testReset() async throws {
    let mockService = MockRickAndMortyService(result: .success(MockData.page1))
    let viewModel = await CharactersViewModel(service: mockService)

    await MainActor.run {
      viewModel.characters = [MockData.character]
      viewModel.nextPageURL = "test"
      viewModel.errorMessage = "Error"
      viewModel.hasError = true
    }

    await viewModel.loadInitial()

    await #expect(viewModel.characters.count == 1)
    await #expect(viewModel.hasError == false)
    await #expect(viewModel.errorMessage == nil)
  }
}
