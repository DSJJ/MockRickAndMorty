//
//  SeenEpisodeModel.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation
import SwiftData

@Model
final class SeenEpisode {
    @Attribute(.unique) var episodeID: Int

    init(episodeID: Int) {
        self.episodeID = episodeID
    }
}
