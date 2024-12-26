//
//  SearchPeopleRepository.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

protocol SearchPeopleRepositoryType {
    func searchPeople(query: String, completion: @escaping (Swift.Result<[PersonDetails], TVMazeApiError>) -> Void)
}

final class SearchPeopleRepository: SearchPeopleRepositoryType {
    let requester: TVMazeApiRequestProtocol

    init(requester: TVMazeApiRequestProtocol = TVMazeApiRequest()) {
        self.requester = requester
    }

    func searchPeople(query: String, completion: @escaping (Result<[PersonDetails], TVMazeApiError>) -> Void) {
        requester.request(with: SearchPeopleServiceSetup.searchPeople(query: query)) { (result: Swift.Result<[Person], TVMazeApiError>) in
            switch result {
            case let .success(persons):
                completion(.success(persons.map({ $0.person })))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
