//
//  FavoriteListViewModel.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

final class FavoriteListViewModel: ObservableObject {
    @Published var favoritesSeries: [Serie] = []
    @Published var seriesList: [Serie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let favoritesManager = FavoritesManager()
    private let repository: FavoriteRepositoryType

    init(repository: FavoriteRepositoryType = FavoriteRepository()) {
        self.repository = repository
    }

    func fetchFavorites() {
        isLoading = true
        for serieId in favoritesManager.getFavorites() {
            repository.fetchFavoriteSerie(serieId: Int(serieId) ?? 0) { [weak self] result in
                self?.isLoading = false

                switch result {
                case let .success(favoriteSerie):
                    self?.favoritesSeries.append(favoriteSerie)
                case let .failure(error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
        _seriesList = _favoritesSeries
    }

    func sortList() {
        seriesList = seriesList.sorted { $0.name < $1.name }
    }
}
