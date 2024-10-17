//
//  MovieService.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import Foundation

// MARK: - Network request

final class MovieService {
    
    func fetchTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        let headers = [
            "x-rapidapi-key": "73f2296a35msh67f9a9720c634b6p17969ajsn84bb057bebff",
            "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com",
            "Type": "get-trending-movies"
        ]
        
        guard let url = URL(string: "https://movies-tv-shows-database.p.rapidapi.com/?page=1") else {
            print("Invalid url")
            return
        }
        
        let request = URLRequest(url: url)
        request.httpMethod = "GET"
    }
    
    func fetchMovieById(){
        
    }
}
