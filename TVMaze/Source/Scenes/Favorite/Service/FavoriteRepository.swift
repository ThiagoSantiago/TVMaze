//
//  FavoriteRepository.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

protocol FavoriteRepositoryType {
    func fetchFavoriteSerie(serieId: Int, completion: @escaping (Swift.Result<Serie, TVMazeApiError>) -> Void)
}

final class FavoriteRepository: FavoriteRepositoryType {
    let requester: TVMazeApiRequestProtocol

    init(requester: TVMazeApiRequestProtocol = TVMazeApiRequest()) {
        self.requester = requester
    }

    func fetchFavoriteSerie(serieId: Int, completion: @escaping (Result<Serie, TVMazeApiError>) -> Void) {
        requester.request(with: FavoriteServiceSetup.getFavoriteSerie(serieId: serieId)) { (result: Swift.Result<Serie, TVMazeApiError>) in
            switch result {
            case let .success(serieDetail):
                completion(.success(serieDetail))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
