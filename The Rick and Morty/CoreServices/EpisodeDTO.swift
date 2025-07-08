//
//  EpisodeDTO.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation

struct EpisodeDTO: Decodable, Identifiable {
    let id: Int
    let name: String
    let episode: String
    let air_date: String
}
