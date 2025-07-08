//
//  The_Rick_and_MortyApp.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import SwiftUI
import SwiftData

@main
struct The_Rick_and_MortyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FavoriteCharacter.self, SeenEpisode.self])
    }
}
