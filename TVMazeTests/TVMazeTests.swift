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

        XCTAssertEqual(sut.series.count, 3)
        XCTAssertEqual(sut.series[0].name, "Game of Thrones")
        XCTAssertEqual(sut.series[1].genres, ["Action"])
        XCTAssertEqual(sut.series[2].summary, "Summary for The Wire")
    }

    func test_fetchSeries_with_error() {
        let repository = SeriesListRepositoryMock()
        repository.showError = true

        let sut = SeriesListViewModel(repository: repository)
        sut.fetchSeries()

        XCTAssertTrue(sut.series.isEmpty)
    }
}
