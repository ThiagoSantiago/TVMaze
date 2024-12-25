//
//  EpisodeListView.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

struct EpisodeListView: View {
    @EnvironmentObject var viewModel: SerieDetailsViewModel

    var body: some View {
        let groupedEpisodes = viewModel.listOfEpisodes.groupedBySeason()
        VStack {
            List {
                ForEach(groupedEpisodes.keys.sorted(), id: \.self) { season in
                    Section(header: Text("Season \(season)").font(.headline)) {
                        createSeasonListView(episodes: groupedEpisodes[season] ?? [])
                    }
                }
            }
            .listStyle(.plain)
            .frame(minHeight: 400)
        }
    }

    @ViewBuilder
    func createSeasonListView(episodes: [Episode]) -> some View {
        ForEach(episodes, id: \.id) { episode in
            NavigationLink {
                EpisodeDetailsView(episode: episode)
            } label: {
                buildSeasonItemView(episode: episode)
            }
        }
    }

    @ViewBuilder
    func buildSeasonItemView(episode: Episode) -> some View {
        VStack(alignment: .leading) {
            Text(episode.name)
                .font(.body)
            Text("Episode \(episode.number)")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

#if DEBUG
#Preview {
    EpisodeListView()
}
#endif
