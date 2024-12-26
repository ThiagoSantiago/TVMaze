//
//  SearchPeopleView.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

struct SearchPeopleView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel: SearchPeopleViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        ForEach(viewModel.peopleSearched, id: \.id) { person in
                            buildPersonRow(person: person)
                        }
                    }
                }
                .navigationTitle("Search People")
            }
            .searchable(text: $searchText, prompt: "search people")
            .onChange(of: searchText) { oldValue, newValue in
                viewModel.searchPeople(query: newValue)
            }
        }
    }

    @ViewBuilder
    func buildPersonRow(person: PersonDetails) -> some View {
        HStack {
            AsyncImage(url: URL(string: person.image?.original ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                } else if phase.error != nil {
                    Color.red
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
            }

            Text(person.name)
                .font(.headline)
                .foregroundColor(.text)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal,16)
    }
}

#if DEBUG
#Preview {
    SearchPeopleView(viewModel: .init())
}
#endif
