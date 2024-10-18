//
//  MovieService.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//
import Foundation


final class MovieService {
    
    private enum Constants {
        static let baseURL = "https://movies-tv-shows-database.p.rapidapi.com/?"
        static let apiKey = "73f2296a35msh67f9a9720c634b6p17969ajsn84bb057bebff"
        static var headers: [String: String] {
            return [
                "x-rapidapi-key": apiKey,
                "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com"
            ]
        }
    }
    
    private func performRequest<T: Decodable>(with url: URL, type: String, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants.headers
        request.addValue(type, forHTTPHeaderField: "Type")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(noDataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    
    func fetchTrendingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        var components = URLComponents(string: Constants.baseURL)
        components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        guard let url = components?.url else {
            print("Invalid URL")
            return
        }
        
        performRequest(with: url, type: "get-trending-movies") { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.movieResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllTrendingMovies(totalPages: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        var allMovies: [Movie] = []
        let dispatchGroup = DispatchGroup()
        
        for page in 1...totalPages {
            dispatchGroup.enter()
            fetchTrendingMovies(page: page) { result in
                switch result {
                case .success(let movies):
                    allMovies.append(contentsOf: movies)
                case .failure(let error):
                    print("Failed to fetch movies from page \(page): \(error.localizedDescription)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(allMovies))
        }
    }
    
    func fetchMovieById(movieId: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        
        var components = URLComponents(string: Constants.baseURL)
        components?.queryItems = [
            URLQueryItem(name: "movieid", value: movieId)
        ]
        guard let url = components?.url else {
            print("Invalid URL")
            return
        }
        
        performRequest(with: url, type: "get-movie-details") { (result: Result<MovieDetail, Error>) in
            switch result {
            case .success(let movieDetail):
                completion(.success(movieDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
