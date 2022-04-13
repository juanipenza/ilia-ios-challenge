//
//  HomeMoviesViewModel.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation
import SwiftUI

class HomeMoviesViewModel: ObservableObject {
    var moviesRepository: MoviesRepositoryProtocol

    /*
     @ALTERAÇÃO
     Mudando para Published para que possa notificar à view
     */
    @Published private(set) var movies: [MovieResponse] = []
    @Published private(set) var state = LoadingState.idle
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }

    /*
     @ALTERAÇÃO
     Implementando o Dispatch para atribuir as alterações dos published à view
     */
    func loadMovies(page: Int) async {
        DispatchQueue.main.async {
            self.state = .loading
        }
        do {
            let movies = try await moviesRepository.getUpcomingMovies(page: page)
            DispatchQueue.main.async {
                self.movies = movies
                self.state = .loaded
            }
        } catch let error {
            DispatchQueue.main.async {
                self.movies = []
                self.state = .failed(error)
            }
        }
    }

    /*
     @ALTERAÇÃO
     Tava errado já que precisamos de ver se tem filmes
     */
    func hasMovies() -> Bool {
        return !movies.isEmpty
    }
}
