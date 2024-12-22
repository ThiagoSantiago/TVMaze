//
//  TVMazeApiSetupProtocol.swift
//  TVMaze
//
//  Created by Thiago Santiago on 22/12/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol TVMazeApiSetupProtocol {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : Any] { get }
    var headers: [String : String] { get }
}

extension TVMazeApiSetupProtocol {
    var headers: [String : String] {
        return [:]
    }

    var parameters: [String : Any] {
        return [:]
    }
}
