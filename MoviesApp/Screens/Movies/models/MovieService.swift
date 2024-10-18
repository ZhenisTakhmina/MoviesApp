//
//  MovieService.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import Foundation

// MARK: - Network request

final class MovieService {
    
    func fetchTrendingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void){
        let headers = [
            "x-rapidapi-key": "73f2296a35msh67f9a9720c634b6p17969ajsn84bb057bebff",
            "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com",
            "Type": "get-trending-movies"
        ]
        
        let session = URLSession.shared
        
        guard let url = URL(string: "https://movies-tv-shows-database.p.rapidapi.com/?page=\(page)") else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received!")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.movieResults))
            } catch {
                print("Failed to parse json: \(error)")
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
        
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
                    print("Failed to fetch movies from page \(page): \(error)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(allMovies))
        }
    }
    
    
    func fetchMovieById(movieId: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let headers = [
            "x-rapidapi-key": "73f2296a35msh67f9a9720c634b6p17969ajsn84bb057bebff",
            "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com",
            "Type": "get-movie-details"
        ]
        
        let urlString = "https://movies-tv-shows-database.p.rapidapi.com/?movieid=\(movieId)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
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
                let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                completion(.success(movieDetail))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}

