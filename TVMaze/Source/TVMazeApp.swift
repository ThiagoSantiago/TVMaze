//
//  TVMazeApp.swift
//  TVMaze
//
//  Created by Thiago Santiago on 22/12/24.
//

import SwiftUI

@main
struct TVMazeApp: App {
    var body: some Scene {
        WindowGroup {
            SeriesListView(viewModel: .init())
        }
    }
}
