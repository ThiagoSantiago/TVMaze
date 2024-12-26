//
//  SerieDetails.swift
//  TVMaze
//
//  Created by Thiago Santiago on 24/12/24.
//

import SwiftUI

struct SerieDetailsView: View {
    @ObservedObject var viewModel: SerieDetailsViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        AsyncImage(url: URL(string: viewModel.imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 250)
                                .cornerRadius(16)
                        } placeholder: {
                            Image("placeholder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 250)
                                .cornerRadius(16)
                        }
                        .frame(width: 200, height: 250)
                        Spacer()
                    }

                    HStack {
                        Button(action: {
                            viewModel.toggleFavorite(viewModel.serieId)
                        }) {
                            Image(systemName: viewModel.isFavorite
                                  ? "heart.circle.fill"
                                  : "heart.circle"
                            )
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(viewModel.isFavorite ? .red : .gray)
                        }
                        .frame(width: 28, height: 28)
                        Spacer()
                    }
                    .padding(.top)

                    VStack(alignment: .leading) {

                        Text(viewModel.summary)
                            .font(.subheadline)
                            .foregroundStyle(Color.text)
                            .padding(.vertical)

                        HStack {
                            Text("Status:")
                                .font(.subheadline)
                                .foregroundStyle(Color.text)
                                .fontWeight(.bold)
                            Text(viewModel.status)
                                .font(.subheadline)
                                .foregroundStyle(Color.text)
                        }
                        .padding(.bottom, 8)

                        HStack {
                            Text("Genres:")
                                .font(.subheadline)
                                .foregroundStyle(Color.text)
                                .fontWeight(.bold)
                            Text(viewModel.genres.joined(separator: " "))
                                .font(.subheadline)
                                .lineLimit(nil)
                                .foregroundStyle(Color.text)
                        }
                        .padding(.bottom, 8)

                        if viewModel.status == "Running" {
                            HStack {
                                Spacer()
                                Text("Schedule:")
                                    .font(.headline)
                                    .foregroundStyle(Color.text)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 16)

                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Time:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.text)
                                        .fontWeight(.bold)
                                    Text(viewModel.schedule?.time ?? "")
                                        .font(.subheadline)
                                        .lineLimit(nil)
                                        .foregroundStyle(Color.text)
                                }

                                HStack {
                                    Text("Days:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.text)
                                        .fontWeight(.bold)
                                    Text(viewModel.schedule?.days.joined(separator: " ") ?? "")
                                        .font(.subheadline)
                                        .lineLimit(nil)
                                        .foregroundStyle(Color.text)
                                }
                            }
                            .padding(.bottom, 8)
                        } else if viewModel.status == "Ended" {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Ended:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.text)
                                        .fontWeight(.bold)
                                    Text(viewModel.serieEnded)
                                        .font(.subheadline)
                                        .lineLimit(nil)
                                        .foregroundStyle(Color.text)
                                }
                            }
                            .padding(.bottom, 8)
                        } else {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Premiered:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.text)
                                        .fontWeight(.bold)
                                    Text(viewModel.seriePremier)
                                        .font(.subheadline)
                                        .lineLimit(nil)
                                        .foregroundStyle(Color.text)
                                }
                            }
                            .padding(.bottom, 8)
                        }

                        HStack {
                            Spacer()
                            Text("Episodes:")
                                .font(.headline)
                                .foregroundStyle(Color.text)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 16)

                        EpisodeListView()
                    }
                }
                .padding()
                .navigationTitle(viewModel.name)
            }
        }
        .environmentObject(viewModel) 
        .onAppear {
            viewModel.fetchSerieDetails()
        }
    }
}

#if DEBUG
#Preview {
    let serie = Serie(id: 1,
                      url: nil,
                      name: "name",
                      type: nil,
                      language: nil,
                      genres: ["Drama"],
                      status: "Running",
                      runtime: nil,
                      averageRuntime: nil,
                      premiered: nil,
                      ended: nil,
                      officialSite: nil,
                      schedule: .init(time: "20:00", days: ["Sunday"]),
                      rating: .init(average: nil),
                      weight: nil,
                      image: nil,
                      summary: nil,
                      updated: nil)
    SerieDetailsView(viewModel: .init(serie: serie))
}
#endif
