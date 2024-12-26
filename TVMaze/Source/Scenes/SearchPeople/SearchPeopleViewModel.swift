//
//  SearchPeopleViewModel.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

final class SearchPeopleViewModel: ObservableObject {
    @Published var peopleSearched: [PersonDetails] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    let repositorry: SearchPeopleRepositoryType

    init(repositorry: SearchPeopleRepositoryType = SearchPeopleRepository()) {
        self.repositorry = repositorry
    }

    func searchPeople(query: String) {
        repositorry.searchPeople(query: query) { [weak self] result in
            switch result {
            case .success(let people):
                self?.peopleSearched = people
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
