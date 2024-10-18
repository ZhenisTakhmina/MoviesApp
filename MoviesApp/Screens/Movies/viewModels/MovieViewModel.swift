//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var selectedMovieDetail: MovieDetail?
    @Published var errorMessage: String?
    
    private let service = MovieService()
    
    func getAllTrendingMovies() {
        service.fetchAllTrendingMovies(totalPages: 5) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    print("Movies: \(movies.count)")
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func getMovieById(movieId: String) {
        service.fetchMovieById(movieId: movieId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetail):
                    self?.selectedMovieDetail = movieDetail
                    print(movieDetail)

                case .failure(let error):
                    self?.errorMessage = "Failed to fetch movie: \(error.localizedDescription)"
                }
            }
        }
    }
}

