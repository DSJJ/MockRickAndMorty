//
//  CharacterDTO.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation

struct CharacterDTO: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Origin: Decodable, Hashable {
    let name: String
    let url: String
}

struct Location: Decodable, Hashable {
    let name: String
    let url: String
}
