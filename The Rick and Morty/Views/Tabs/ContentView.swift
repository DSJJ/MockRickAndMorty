//
//  ContentView.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      CharactersView()
        .tabItem {
          Label("Personajes", systemImage: "figure.walk.diamond")
        }
      
      FavoritesView()
        .tabItem {
          Label("Favoritos", systemImage: "medal.star")
        }
    }
  }
}

#Preview {
  ContentView()
}
