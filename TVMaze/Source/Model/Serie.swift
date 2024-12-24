//
//  Serie.swift
//  TVMaze
//
//  Created by Thiago Santiago on 22/12/24.
//

import Foundation

struct Serie: Decodable {
    let id: Int
        let url: String?
        let name: String
        let type: String?
        let language: String?
        let genres: [String]
        let status: String
        let runtime: Int?
        let averageRuntime: Int?
        let premiered: String?
        let ended: String?
        let officialSite: String?
        let schedule: Schedule
        let rating: Rating
        let weight: Int?
        let image: Image?
        let summary: String?
        let updated: Int?

        enum CodingKeys: String, CodingKey {
            case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, image, summary, updated
        }
}

struct Schedule: Decodable {
    let time: String
    let days: [String]
}

struct Rating: Decodable {
    let average: Double?
}

struct Image: Decodable {
    let medium, original: String
}

struct SerieElement: Decodable {
    let score: Double
    let show: Serie
}
