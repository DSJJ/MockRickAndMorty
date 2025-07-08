//
//  FavoritesView.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
  @Environment(\.modelContext) private var context
  @Query private var favorites: [FavoriteCharacter]

  @State private var characters: [Character] = []
  @State private var isLoading = false
  @State private var hasError = false
  @State private var isAuthorized = false
  @State private var attemptedAuth = false

  var body: some View {
    NavigationStack {
      Group {
        if isAuthorized {
          if isLoading {
            ProgressView("Cargando favoritos...")
          } else if characters.isEmpty {
            Text("No tienes personajes favoritos.")
              .foregroundColor(.secondary)
              .padding()
          } else {
            ScrollView {
              LazyVStack {
                ForEach(characters, id: \.id) { character in
                  CapsuleCell(
                    imageURL: character.image,
                    name: character.name,
                    species: character.species,
                    status: character.status
                  )
                  .padding(.horizontal)
                }
              }
              .padding(.top)
            }
          }
        } else {
          RestrictedAccessView {
            Task {
              await authenticate()
            }
          }
        }
      }
      .navigationTitle("Favoritos")
      .task {
        if !attemptedAuth {
          attemptedAuth = true
          await authenticate()
        }
      }
    }
  }

  private func authenticate() async {
    let success = await BiometricAuth.authenticate()
    await MainActor.run {
      isAuthorized = success
      if success {
        Task { await loadFavorites() }
      }
    }
  }

  private func loadFavorites() async {
    isLoading = true
    hasError = false
    do {
      let ids = favorites.map { String($0.characterID) }.joined(separator: ",")
      guard !ids.isEmpty else {
        characters = []
        isLoading = false
        return
      }

      let url = URL(string: "https://rickandmortyapi.com/api/character/\(ids)")!
      let (data, response) = try await URLSession.shared.data(from: url)

      guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
        throw URLError(.badServerResponse)
      }

      if ids.contains(",") {
        characters = try JSONDecoder().decode([Character].self, from: data)
      } else {
        let single = try JSONDecoder().decode(Character.self, from: data)
        characters = [single]
      }

    } catch {
      hasError = true
      print("Error cargando personajes favoritos: \(error)")
    }
    isLoading = false
  }
}

#Preview("FavoritesView con SwiftData") {
  do {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: FavoriteCharacter.self, configurations: config)

    let context = container.mainContext
    context.insert(FavoriteCharacter(characterID: 1))

    return FavoritesView()
      .modelContainer(container)
  } catch {
    return Text("Error al crear preview: \(error.localizedDescription)")
  }
}
