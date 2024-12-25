//
//  SerieDetailsServiceSetup.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

enum SerieDetailsServiceSetup: TVMazeApiSetupProtocol {
    case getSerieDetails(serieId: Int)

    var endpoint: String {
        switch self {
        case let .getSerieDetails(serieId):
            guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else { return "" }
            let url = baseUrl+"/shows/\(serieId)/episodes"

            return url
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getSerieDetails:
            return .get
        }
    }
}
