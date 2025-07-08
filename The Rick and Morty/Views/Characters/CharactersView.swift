//
//  CharactersView.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI

struct CharactersView: View {
  @StateObject var viewModel: CharactersViewModel = CharactersViewModel()
  @State private var showingFilters = false
  @State private var selectedCharacter: Character?
  
  @Environment(\.modelContext) private var modelContext
  
  var body: some View {
    NavigationStack {
      VStack {
        if viewModel.hasError {
          VStack(spacing: 8) {
            Text("Error: \(viewModel.errorMessage ?? "desconocido")")
            Button("Reintentar") {
              Task { await viewModel.loadInitial() }
            }
          }
          .padding()
        } else if viewModel.characters.isEmpty && !viewModel.isLoading {
          Text("Sin resultados.")
            .padding()
        } else {
          ScrollView {
            LazyVStack {
              ForEach(viewModel.characters) { character in
                let image = character.image
                let name = character.name
                let species = character.species
                let status = character.status
                
                CapsuleCell(
                  imageURL: image,
                  name: name,
                  species: species,
                  status: status
                )
                .onTapGesture {
                  selectedCharacter = character
                }
                .onAppear {
                  Task { await viewModel.loadMoreIfNeeded(current: character) }
                }
              }
              
              if viewModel.isLoading {
                ProgressView()
                  .padding()
              }
            }
            .padding(.top)
          }
          .refreshable {
            await viewModel.refresh()
          }
        }
      }
      .navigationTitle("Personajes")
      .navigationDestination(item: $selectedCharacter) { character in
        DetailView(character: character, modelContext: modelContext)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showingFilters = true
          } label: {
            Label("Filtros", systemImage: "line.3.horizontal.decrease.circle")
          }
        }
      }
      .searchable(text: $viewModel.searchText, prompt: "Buscar por nombre")
      .onChange(of: viewModel.searchText) { oldValue, newValue in
        if newValue.isEmpty {
          Task { await viewModel.loadInitial() }
        }
      }
      .onSubmit(of: .search) {
        Task { await viewModel.loadInitial() }
      }
      .sheet(isPresented: $showingFilters) {
        FilterSheetView(
          filterStatus: $viewModel.filterStatus,
          filterSpecies: $viewModel.filterSpecies
        ) {
          Task { await viewModel.loadInitial() }
        }
      }
      .task {
        await viewModel.loadInitial()
      }
    }
  }
}

#Preview {
  CharactersView()
}
