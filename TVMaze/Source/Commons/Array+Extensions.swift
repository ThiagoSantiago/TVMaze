//
//  Array+Extensions.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import Foundation

extension Array where Element == Episode {
    func groupedBySeason() -> [Int: [Episode]] {
        Dictionary(grouping: self) { $0.season }
    }
}
