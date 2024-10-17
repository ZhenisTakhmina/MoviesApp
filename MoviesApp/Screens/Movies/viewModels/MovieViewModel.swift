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
    
    func getTrendingMovies() {
        service.fetchTrendingMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    print("Movies: \(movies)")
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
                    
                    let title = movieDetail.title ?? "Title is missing"
                    let description = movieDetail.description ?? "Description is missing"
                    let year = movieDetail.year ?? "Year is missing"
                    let releaseDate = movieDetail.releaseDate ?? "Release date is missing"
                    let imdbID = movieDetail.imdbID ?? "IMDB ID is missing"
                    let imdbRating = movieDetail.imdbRating ?? "IMDB rating is missing"
                    let rated = movieDetail.rated ?? "Rated is missing"
                    let runtime = movieDetail.runtime != nil ? "\(movieDetail.runtime!) minutes" : "Runtime is missing"
                    let genres = movieDetail.genres?.joined(separator: ", ") ?? "Genres are missing"

                    let movieInfo = "Title: \(title) /n Description: \(description) /n Year: \(year) /n Release Date: \(releaseDate) /n IMDB ID: \(imdbID) /n IMDB Rating: \(imdbRating) /n Rated: \(rated) /n Runtime: \(runtime) /n Genres: \(genres)"

                    print(movieInfo)

                case .failure(let error):
                    self?.errorMessage = "Failed to fetch movie: \(error.localizedDescription)"
                }
            }
        }
    }
}

