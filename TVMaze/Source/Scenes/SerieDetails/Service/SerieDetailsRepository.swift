//
//  ServiceDetailsRepository.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

protocol SerieDetailsRepositoryType {
    func fetchSerieDetails(serieId: Int, completion: @escaping (Swift.Result<[SerieDetail], TVMazeApiError>) -> Void)
}

final class SerieDetailsRepository: SerieDetailsRepositoryType {

    let requester: TVMazeApiRequestProtocol
    private var serieDetails: SerieDetail?

    init(requester: TVMazeApiRequestProtocol = TVMazeApiRequest()) {
        self.requester = requester
    }

    func fetchSerieDetails(serieId: Int, completion: @escaping (Swift.Result<[SerieDetail], TVMazeApiError>) -> Void) {
        requester.request(with: SerieDetailsServiceSetup.getSerieDetails(serieId: serieId)) { (result: Swift.Result<[SerieDetail], TVMazeApiError>) in
            switch result {
            case let .success(serieDetails):
                completion(.success(serieDetails))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
