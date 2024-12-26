//
//  SerieDetailsViewModel.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

final class SerieDetailsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var serieId: String = ""
    @Published var name: String = ""
    @Published var status: String = ""
    @Published var imageUrl: String = ""
    @Published var genres: [String] = []
    @Published var summary: String = ""
    @Published var serieEnded: String = ""
    @Published var seriePremier: String = ""
    @Published var schedule: Schedule? = nil
    @Published var listOfEpisodes: [Episode] = []
    @Published var isFavorite: Bool = false
    @Published var errorMessage: String?

    private var serie: Serie
    let favoritesManager = FavoritesManager()
    private let repository: SerieDetailsRepositoryType

    init(
        serie: Serie,
        repository: SerieDetailsRepositoryType = SerieDetailsRepository()
    ) {
        self.serie = serie
        self.repository = repository
        serieId = "\(serie.id)"
        name = serie.name
        status = serie.status
        imageUrl = serie.image?.original ?? ""
        genres = serie.genres
        summary = serie.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? ""
        serieEnded = serie.ended ?? ""
        seriePremier = serie.premiered ?? ""
        schedule = serie.schedule

        verifyFavorite(serieId)
    }

    func fetchSerieDetails() {
        isLoading = true
        repository.fetchSerieDetails(serieId: serie.id, completion: { [weak self] result in
            self?.isLoading = false

            switch result {
            case let .success(serieDetails):
                let episodes = serieDetails.map {
                    Episode(
                        id: $0.id,
                        name: $0.name,
                        season: $0.season,
                        number: $0.number,
                        summary: $0.summary,
                        imageUrl: $0.image?.original
                    )
                }
                self?.listOfEpisodes = episodes
            case let .failure(error):
                self?.errorMessage = error.localizedDescription
            }
        })
    }

    func toggleFavorite(_ id: String) {
        if favoritesManager.isFavorite(id: id) {
            favoritesManager.removeFavorite(id: id)
            isFavorite = false
        } else {
            favoritesManager.addFavorite(id: id)
            isFavorite = true
        }
    }

    private func verifyFavorite(_ id: String) {
        isFavorite = favoritesManager.isFavorite(id: id)
    }
}
