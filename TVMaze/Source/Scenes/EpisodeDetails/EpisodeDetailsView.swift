//
//  EpisodeDetailsView.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: Episode

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: episode.imageUrl ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .cornerRadius(16)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 250)
                    Spacer()
                }

                VStack(alignment: .leading) {

                    let summary = episode.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
                    Text(summary)
                        .font(.subheadline)
                        .foregroundStyle(Color.text)
                        .padding(.vertical)

                    HStack {
                        Text("Season:")
                            .font(.subheadline)
                            .foregroundStyle(Color.text)
                            .fontWeight(.bold)
                        Text("\(episode.season)")
                            .font(.subheadline)
                            .foregroundStyle(Color.text)
                    }
                    .padding(.vertical, 8)

                    HStack {
                        Text("Episode:")
                            .font(.subheadline)
                            .foregroundStyle(Color.text)
                            .fontWeight(.bold)
                        Text("\(episode.number)")
                            .font(.subheadline)
                            .foregroundStyle(Color.text)
                    }
                    .padding(.vertical, 8)
                }
            }
            .padding()
            .navigationTitle(episode.name)
        }
    }
}

#if DEBUG
#Preview {
    EpisodeDetailsView(episode: Episode(id: 1,
                                        name: "Episode",
                                        season: 1,
                                        number: 1,
                                        summary: "summary",
                                        imageUrl: nil)
    )
}
#endif
