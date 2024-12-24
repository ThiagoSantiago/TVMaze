//
//  SeriesListRepositoryMock.swift
//  TVMazeTests
//
//  Created by Thiago Santiago on 24/12/24.
//

import Foundation

final class SeriesListRepositoryMock: SeriesListRepositoryType {
    var showError: Bool = false
    private let series: [Serie] = [
        Serie(id: 1,
              url: nil,
              name: "Game of Thrones",
              type: nil,
              language: nil,
              genres: ["Drama"],
              status: "ended",
              runtime: nil,
              averageRuntime: nil,
              premiered: "2013-06-24",
              ended: "2015-09-10",
              officialSite: nil,
              schedule: .init(time: "22:00", days: ["Tuesday"]),
              rating: .init(average: 8.8),
              weight: nil,
              image: nil,
              summary: "Summary for Game of Thrones",
              updated: 1724121898),
        Serie(id: 2,
              url: nil,
              name: "The Walking Dead",
              type: nil,
              language: nil,
              genres: ["Action"],
              status: "running",
              runtime: nil,
              averageRuntime: nil,
              premiered: "2013-06-24",
              ended: nil,
              officialSite: nil,
              schedule: .init(time: "20:00", days: ["Thursday"]),
              rating: .init(average: 7.8),
              weight: nil,
              image: nil,
              summary: "Summary for The Walking Dead",
              updated: 1724121348),
        Serie(id: 3,
              url: nil,
              name: "The Wire",
              type: nil,
              language: nil,
              genres: ["Crime"],
              status: "To Be Determined",
              runtime: nil,
              averageRuntime: nil,
              premiered: "2013-06-24",
              ended: nil,
              officialSite: nil,
              schedule: .init(time: "18:00", days: ["Saturday"]),
              rating: .init(average: 6.8),
              weight: nil,
              image: nil,
              summary: "Summary for The Wire",
              updated: 17241234548)
    ]

    func fetchSeriesList(page: Int, completion: @escaping (Swift.Result<[Serie], TVMazeApiError>) -> Void) {
        if showError {
            completion(.failure(TVMazeApiError.badRequest))
        } else {
            completion(.success(series))
        }
    }

    func searchSeries(query: String, completion: @escaping (Swift.Result<[Serie], TVMazeApiError>) -> Void) {
        if showError {
            completion(.failure(TVMazeApiError.badRequest))
        } else {
            completion(.success([
                Serie(id: 1,
                      url: nil,
                      name: "Game of Thrones",
                      type: nil,
                      language: nil,
                      genres: ["Drama"],
                      status: "ended",
                      runtime: nil,
                      averageRuntime: nil,
                      premiered: "2013-06-24",
                      ended: "2015-09-10",
                      officialSite: nil,
                      schedule: .init(time: "22:00", days: ["Tuesday"]),
                      rating: .init(average: 8.8),
                      weight: nil,
                      image: nil,
                      summary: "Summary for Game of Thrones",
                      updated: 1724121898)
            ]))
        }
    }
}
