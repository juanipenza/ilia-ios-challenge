//
//  FavoritesRepository.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import Foundation

protocol FavoritesRepositoryProtocol {
    func getFavoriteMovies() -> [MovieResponse]
    func saveFavoriteMovie(movie: MovieResponse)
    func deleteFavoriteMovie(movie: MovieResponse)
    func isFavoriteMovie(movie: MovieResponse) -> Bool
}


class FavoritesRepository: FavoritesRepositoryProtocol {
    let key: String = "favorite_movies"
    
    func getFavoriteMovies() -> [MovieResponse] {
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: Array<MovieResponse>.self, key: key) {
            return retrievedCodableObject
        } else {
            return []
        }
    }

    /*
     @INSERÇÃO
     Implementado para adicionar um filme
     */
    func saveFavoriteMovie(movie: MovieResponse) {
        var movies = getFavoriteMovies()
        movies.append(movie)
        do {
            let data = try JSONEncoder().encode(movies)
            UserDefaults.standard.set(data, forKey: key)
        }
        catch {
            fatalError("Encoding error")
        }
    }

    /*
     @INSERÇÃO
     Implementado para deletar um filme
     */
    func deleteFavoriteMovie(movie: MovieResponse) {
        var movies = getFavoriteMovies()
        movies.removeAll { movieSaved in
            movieSaved == movie
        }
        
        do {
            let data = try JSONEncoder().encode(movies)
            UserDefaults.standard.set(data, forKey: key)
        }
        catch {
            fatalError("Encoding error")
        }
    }

    /*
     @INSERÇÃO
     Implementado para ver se um filme é favorito
     */
    func isFavoriteMovie(movie: MovieResponse) -> Bool {
        let movies = getFavoriteMovies()
        return !movies.filter { movieSaved in
            movieSaved == movie
        }
        .isEmpty
    }
}
