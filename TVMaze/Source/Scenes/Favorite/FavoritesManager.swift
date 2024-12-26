//
//  FavoritesManager.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

struct FavoritesManager {
    private let favoritesKey = "favorites"

    func getFavorites() -> [String] {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: favoritesKey) as? [String] ?? []
    }

    func addFavorite(id: String) {
        var favorites = getFavorites()
        if !favorites.contains(id) {
            favorites.append(id)
            saveFavorites(favorites)
        }
    }

    func removeFavorite(id: String) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }

    func isFavorite(id: String) -> Bool {
        return getFavorites().contains(id)
    }

    private func saveFavorites(_ favorites: [String]) {
        let defaults = UserDefaults.standard
        defaults.set(favorites, forKey: favoritesKey)
    }
}
