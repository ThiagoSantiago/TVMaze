//
//  TVMazeTests.swift
//  TVMazeTests
//
//  Created by Thiago Santiago on 22/12/24.
//

import XCTest
@testable import TVMaze

final class SeriesListViewModelTests: XCTestCase {

    func test_fetchSeries_with_success() {
        let sut = SeriesListViewModel(repository: SeriesListRepositoryMock())
        sut.fetchSeries()

        XCTAssertEqual(sut.seriesList.count, 3)
        XCTAssertEqual(sut.seriesList[0].name, "Game of Thrones")
        XCTAssertEqual(sut.seriesList[1].genres, ["Action"])
        XCTAssertEqual(sut.seriesList[2].summary, "Summary for The Wire")
    }

    func test_fetchSeries_with_error() {
        let repository = SeriesListRepositoryMock()
        repository.showError = true

        let sut = SeriesListViewModel(repository: repository)
        sut.fetchSeries()

        XCTAssertTrue(sut.seriesList.isEmpty)
    }

    func test_searchSeries_with_success() {
        let sut = SeriesListViewModel(repository: SeriesListRepositoryMock())
        sut.searchSeries(for: "Game")

        XCTAssertEqual(sut.seriesList.count, 1)
        XCTAssertEqual(sut.seriesList[0].name, "Game of Thrones")
    }
}
