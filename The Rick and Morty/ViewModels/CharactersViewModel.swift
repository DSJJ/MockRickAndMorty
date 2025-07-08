//
//  CharactersViewModel.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation

@MainActor
class CharactersViewModel: ObservableObject {
  @Published var characters: [Character] = []
  @Published var nextPageURL: String?
  @Published var errorMessage: String?
  @Published var isLoading: Bool = false
  @Published var hasError = false
  @Published var searchText: String = ""
  @Published var filterStatus: String = ""
  @Published var filterSpecies: String = ""
  
  private let service: RickAndMortyServiceProtocol

  init(service: RickAndMortyServiceProtocol = RickAndMortyService()) {
    self.service = service
  }
  
  func loadInitial() async {
    reset()
    await fetch(page: 1)
  }
  
  func loadMoreIfNeeded(current: Character) async {
    guard let last = characters.last, current.id == last.id else { return }
    await fetchNextPage()
  }
  
  func refresh() async {
    await loadInitial()
  }
  
  private func reset() {
    characters = []
    nextPageURL = nil
    hasError = false
    errorMessage = nil
  }
  
  private func fetch(page: Int) async {
    isLoading = true
    do {
      let result = try await service.fetchCharacters(page: page, name: searchText, status: filterStatus, species: filterSpecies)
      characters = result.results
      nextPageURL = result.info.next
    } catch {
      hasError = true
      errorMessage = error.localizedDescription
    }
    isLoading = false
  }
  
  private func fetchNextPage() async {
    guard let url = nextPageURL, !isLoading else { return }
    isLoading = true
    do {
      let result = try await service.fetchCharacters(from: url)
      characters += result.results
      nextPageURL = result.info.next
    } catch {
      hasError = true
      errorMessage = error.localizedDescription
    }
    isLoading = false
  }
}


