//
//  FavoriteListView.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

struct FavoriteListView: View {
    @ObservedObject var viewModel: FavoriteListViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    if viewModel.isLoading {
                        ProgressView("Loading favorites...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        ForEach(viewModel.seriesList, id: \.id) { serie in
                            NavigationLink {
                                let viewModel = SerieDetailsViewModel(serie: serie)
                                SerieDetailsView(viewModel: viewModel)
                            } label: {
                                buildItemListView(item: serie)
                            }
                        }
                    }
                }
                .navigationTitle("Favorites")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.sortList()
                        }) {
                            Image("sort.alpha.down")
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchFavorites()
        }
    }

    @ViewBuilder
    func buildItemListView(item: Serie) -> some View {
        HStack {
            AsyncImage(url: URL(string: item.image?.medium ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 150)
                    .cornerRadius(16)
            } placeholder: {
                Image("placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 150)
                    .cornerRadius(16)
            }
            .frame(width: 100, height: 150)

            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.text)
                    .padding(.top, 8)

                HStack {
                    Text("Status:")
                        .font(.subheadline)
                        .foregroundStyle(Color.text)
                        .fontWeight(.bold)
                    Text(item.status)
                        .font(.subheadline)
                        .foregroundStyle(Color.text)
                }
                .padding(.top, 8)

                HStack {
                    Text(
                        item.status == "Ended"
                        ? "Ended:"
                        : "Premiered:"
                    )
                    .font(.subheadline)
                    .foregroundStyle(Color.text)
                    .fontWeight(.bold)

                    Text(
                        (item.status == "Ended"
                         ? item.ended?.convertDateStringToUserLocale() ?? "-"
                         : item.premiered?.convertDateStringToUserLocale()) ?? "-"
                    )
                    .font(.subheadline)
                    .foregroundStyle(Color.text)
                }
            }
            Spacer()
        }
        .cornerRadius(16)
        .padding()
    }
}

#Preview {
    let viewModel = FavoriteListViewModel()
    FavoriteListView(viewModel: viewModel)
}
