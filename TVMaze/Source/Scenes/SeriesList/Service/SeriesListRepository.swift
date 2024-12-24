//
//  SeriesListRepository.swift
//  TVMaze
//
//  Created by Thiago Santiago on 22/12/24.
//

import Foundation

protocol SeriesListRepositoryType {
    func fetchSeriesList(page: Int, completion: @escaping (Swift.Result<[Serie], TVMazeApiError>) -> Void)
}

final class SeriesListRepository: SeriesListRepositoryType {

    let requester: TVMazeApiRequestProtocol
    private var allSeries: [Serie] = []

    init(requester: TVMazeApiRequestProtocol = TVMazeApiRequest()) {
        self.requester = requester
    }

    func fetchSeriesList(page: Int, completion: @escaping (Swift.Result<[Serie], TVMazeApiError>) -> Void) {
        requester.request(with: SeriesListServiceSetup.getSeriesList(page: page)) { (result: Swift.Result<[Serie], TVMazeApiError>) in
            switch result {
            case let .success(series):
                completion(.success(series))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
