//
//  SeriesListServiceSetup.swift
//  TVMaze
//
//  Created by Thiago Santiago on 22/12/24.
//

import Foundation

enum SeriesListServiceSetup: TVMazeApiSetupProtocol {
    case getSeriesList(page: Int)
    case searchSeries(query: String)

    var endpoint: String {
        switch self {
        case let .getSeriesList(page):
            guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else { return "" }
            let url = baseUrl+"/shows?page=\(page)"

            return url
        case let .searchSeries(query):
            guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else { return "" }
            let url = baseUrl+"/shows??q=girls"

            return url
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getSeriesList, .searchSeries:
            return .get
        }
    }
}
