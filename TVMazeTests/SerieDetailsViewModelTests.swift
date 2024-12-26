//
//  SerieDetailsViewModelTests.swift
//  TVMazeTests
//
//  Created by Thiago Santiago on 25/12/24.
//

import XCTest
@testable import TVMaze

final class SerieDetailsViewModelTests: XCTestCase {
    let serie = Serie(
        id: 1,
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

    func test_fetchSerieDetails_with_success() {
        let sut = SerieDetailsViewModel(serie: serie, repository: SerieDetailsRepositoryMock())
        sut.fetchSerieDetails()

        XCTAssertEqual(sut.listOfEpisodes.count, 3)
        XCTAssertEqual(sut.name, "Game of Thrones")
        XCTAssertEqual(sut.listOfEpisodes[0].name, "Pilot")
        XCTAssertEqual(sut.listOfEpisodes[1].season, 1)
        XCTAssertEqual(sut.listOfEpisodes[2].number, 3)
    }

    func test_fetchSerieDetails_with_error() {
        let repository = SerieDetailsRepositoryMock()
        repository.showError = true

        let sut = SerieDetailsViewModel(serie: serie, repository: repository)
        sut.fetchSerieDetails()

        XCTAssertEqual(sut.errorMessage, TVMazeApiError.badRequest.localizedDescription)
    }
}
