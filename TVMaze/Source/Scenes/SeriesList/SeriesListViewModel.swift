//
//  SeriesListViewModel.swift
//  TVMaze
//
//  Created by Thiago Santiago on 22/12/24.
//

import Foundation

final class SeriesListViewModel: ObservableObject {
    @Published var series: [Serie] = []
    @Published var filteredSeries: [Serie] = []
    @Published var isLoading: Bool = false
    @Published var canLoadMorePages = true

    private var requestPage: Int = 0
    private let repository: SeriesListRepositoryType

    init(repository: SeriesListRepositoryType = SeriesListRepository()) {
        self.repository = repository
    }

    func fetchSeries() {
        guard !isLoading && canLoadMorePages else { return }

        isLoading = true
        repository.fetchSeriesList(page: requestPage, completion: { [weak self] result in
            self?.isLoading = false
            self?.requestPage += 1
            switch result {
            case let .success(series):
                self?.series.append(contentsOf: series)
            case let .failure(error):
                if error == .couldNotFindHost {
                    self?.canLoadMorePages = false
                } else {
                    print("Error trying to fetch series: \(error)")
                }
            }
        })
    }
}