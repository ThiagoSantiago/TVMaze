//
//  SerieDetailsViewModel.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

final class SerieDetailsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var name: String = ""
    @Published var status: String = ""
    @Published var imageUrl: String = ""
    @Published var genres: [String] = []
    @Published var summary: String = ""
    @Published var serieEnded: String = ""
    @Published var seriePremier: String = ""
    @Published var schedule: Schedule? = nil
    @Published var listOfEpisodes: [Episode] = []

    private var serie: Serie
    private let repository: SerieDetailsRepositoryType

    init(
        serie: Serie,
        repository: SerieDetailsRepositoryType = SerieDetailsRepository()
    ) {
        self.serie = serie
        self.repository = repository
        name = serie.name
        status = serie.status
        imageUrl = serie.image?.original ?? ""
        genres = serie.genres
        summary = serie.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? ""
        serieEnded = serie.ended ?? ""
        seriePremier = serie.premiered ?? ""
        schedule = serie.schedule
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
                print("Error trying to fetch series: \(error)")
            }
        })
    }
}
