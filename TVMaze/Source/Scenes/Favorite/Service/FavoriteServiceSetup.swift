//
//  FavoriteServiceSetup.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

enum FavoriteServiceSetup: TVMazeApiSetupProtocol {
    case getFavoriteSerie(serieId: Int)

    var endpoint: String {
        switch self {
        case let .getFavoriteSerie(serieId):
            guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else { return "" }
            let url = baseUrl+"/shows/\(serieId)"

            return url
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getFavoriteSerie:
            return .get
        }
    }
}
