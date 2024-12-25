//
//  SerieDetails.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

struct SerieDetail: Decodable {
    let id: Int
    let url: String?
    let name: String
    let season: Int
    let number: Int
    let type: String?
    let airdate: String?
    let runtime: Int?
    let rating: Rating
    let image: Image?
    let summary: String

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, runtime, rating, image, summary
    }
}

struct Episode: Decodable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let imageUrl: String?
}
