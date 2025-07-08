//
//  DetailView.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI
import MapKit
import SwiftData

struct DetailView: View {
  let character: Character
  @State private var showMap = false
  @StateObject private var viewModel: DetailViewModel
  
  init(character: Character, modelContext: ModelContext) {
    self.character = character
    let repository = SwiftDataFavoritesRepository(context: modelContext)
    _viewModel = StateObject(wrappedValue: DetailViewModel(repository: repository))
  }
  
  var body: some View {
    ScrollView {
      VStack {
        AsyncImage(url: URL(string: character.image)) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
        } placeholder: {
          ProgressView()
        }
        
        HStack {
          VStack(alignment: .leading, spacing: 8) {
            Text(character.name)
              .font(.largeTitle)
              .bold()
            Text("\(character.species) • \(character.gender)")
            Text("Estado: \(character.status)")
            Text("Última ubicación: \(character.location.name)")
          }
          .padding(.horizontal)
          Spacer()
        }
        
        HStack {
          Spacer()
          Button(action: {
            viewModel.toggleFavorite(characterID: character.id)
          }) {
            Label("Favorito", systemImage: viewModel.isFavorite ? "star.fill" : "star")
              .foregroundColor(.yellow)
              .padding()
              .background(Capsule().stroke(Color.yellow))
          }
          
          Button("Ver en mapa") {
            showMap = true
          }
          .padding()
          .background(Capsule().fill(Color.blue.opacity(0.2)))
          .foregroundColor(.blue)
          
          Spacer()
        }
        .padding()
        
        if viewModel.episodes.isEmpty {
          ProgressView("Cargando episodios...")
        } else {
          VStack(alignment: .leading, spacing: 8) {
            Text("Episodios:")
              .font(.title3)
              .bold()
            
            ForEach(viewModel.episodes) { episode in
              HStack {
                VStack(alignment: .leading) {
                  Text("\(episode.episode) - \(episode.name)")
                    .font(.subheadline)
                  Text(episode.air_date)
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button {
                  viewModel.toggleEpisodeSeen(episode.id)
                } label: {
                  Image(systemName: viewModel.seenEpisodeIDs.contains(episode.id) ? "eye.fill" : "eye")
                    .foregroundColor(.blue)
                }
              }
              .padding(.vertical, 4)
            }
          }
          .padding(.horizontal)
        }
      }
    }
    .sheet(isPresented: $showMap) {
      CharacterMapView(location: CharacterLocation(
        name: character.location.name,
        coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)
      ))
    }
    .task {
      await viewModel.load(characterID: character.id, episodeURLs: character.episode)
    }
  }
}

#Preview {
  do {
    let container = try ModelContainer(
      for: FavoriteCharacter.self, SeenEpisode.self,
      configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    let context = container.mainContext
    
    return DetailView(
      character: Character(id: 1,
                           name: "Rick Sanchez",
                           status: "Alive",
                           species:  "Human",
                           type: "",
                           gender: "Male",
                           origin: Origin(name: "Earth",
                                          url: "https://rickandmortyapi.com/api/location/1"),
                           location: Location(name: "Earth",
                                              url: "https://rickandmortyapi.com/api/location/20"),
                           image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                           episode: ["https://rickandmortyapi.com/api/episode/1",
                                     "https://rickandmortyapi.com/api/episode/2"],
                           url: "https://rickandmortyapi.com/api/character/1",
                           created: "2017-11-04T18:48:46.250Z"),
      modelContext: context
    )
    .modelContainer(container)
    
  } catch {
    return Text("Error cargando preview: \(error.localizedDescription)")
  }
}
