//
//  FavoriteCharacterModel.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import Foundation
import SwiftData

@Model
final class FavoriteCharacter {
    @Attribute(.unique) var characterID: Int

    init(characterID: Int) {
        self.characterID = characterID
    }
}
