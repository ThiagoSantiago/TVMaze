//
//  Person.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

struct Person: Decodable {
    let score: Double
    let person: PersonDetails
}

struct PersonDetails: Decodable {
    let id: Int
    let url: String
    let name: String
    let image: PersonImage?

    enum CodingKeys: String, CodingKey {
        case id, url, name, image
    }
}

struct PersonImage: Decodable {
    let medium, original: String
}
