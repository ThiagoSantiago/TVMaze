//
//  SerieDetailsRepositoryMock.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

final class SerieDetailsRepositoryMock: SerieDetailsRepositoryType {
    var showError: Bool = false

    var seriesDetails: [SerieDetail] = [
        SerieDetail(id: 1,
                    url: nil,
                    name: "Pilot",
                    season: 1,
                    number: 1,
                    type: "Ended",
                    airdate: nil,
                    runtime: nil,
                    rating: .init(average: 8.8),
                    image: nil,
                    summary: "Pilot summary"),
        SerieDetail(id: 2,
                    url: nil,
                    name: "The Fire",
                    season: 1,
                    number: 2,
                    type: "Running",
                    airdate: nil,
                    runtime: nil,
                    rating: .init(average: 7.8),
                    image: nil,
                    summary: "The Fire summary"),
        SerieDetail(id: 3,
                    url: nil,
                    name: "Blue on Blue",
                    season: 1,
                    number: 3,
                    type: "To Be Determined",
                    airdate: nil,
                    runtime: nil,
                    rating: .init(average: 6.8),
                    image: nil,
                    summary: "Blue on Blue summary")
    ]

    func fetchSerieDetails(serieId: Int, completion: @escaping (Result<[SerieDetail], TVMazeApiError>) -> Void) {
        if showError {
            seriesDetails = []
            completion(.failure(TVMazeApiError.badRequest))
        } else {
            completion(.success(seriesDetails))
        }
    }
}
