//
//  String+Extensions.swift
//  TVMaze
//
//  Created by Thiago Santiago on 24/12/24.
//

import Foundation

extension String {

    func convertDateStringToUserLocale() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = inputFormatter.date(from: self) else {
            return self
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .medium
        outputFormatter.timeStyle = .none
        outputFormatter.locale = Locale.current

        return outputFormatter.string(from: date)
    }
}
