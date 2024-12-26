//
//  SearchPeopleServiceSetup.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

enum SearchPeopleServiceSetup: TVMazeApiSetupProtocol {
    case searchPeople(query: String)

    var endpoint: String {
        switch self {
        case let .searchPeople(query):
            guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else { return "" }
            let url = baseUrl+"/search/people?q=\(query)"

            return url
        }
    }

    var method: HTTPMethod {
        switch self {
        case .searchPeople:
            return .get
        }
    }
}
