//
//  ShowsListView.swift
//  TVMaze
//
//  Created by Thiago Santiago on 22/12/24.
//

import SwiftUI

struct SeriesListView: View {
    @ObservedObject var viewModel: SeriesListViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.seriesList, id: \.id) { serie in
                        NavigationLink {
                            SerieDetails()
                        } label: {
                            buildItemListView(item: serie)
                        }
                    }

                    if viewModel.isLoading {
                        loadingView
                    } else if viewModel.canLoadMorePages {
                        loadingPaginationView
                    }
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            viewModel.fetchSeries()
        }
        .background(Color.background)
        .searchable(text: $searchText, prompt: "search series by name")
        .onChange(of: searchText) { oldValue, newValue in
            viewModel.searchSeries(for: newValue)
        }
    }

    var loadingView: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }

    var loadingPaginationView: some View {
        HStack {
            Spacer()
            Text("Loading more...")
                .onAppear {
                    viewModel.fetchSeries()
                }
            Spacer()
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
                ProgressView()
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
                Spacer()
            }
            Spacer()
        }
        .cornerRadius(16)
        .padding()
    }
}

#if DEBUG
#Preview {
    SeriesListView(viewModel: .init())
}
#endif
