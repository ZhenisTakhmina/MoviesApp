//
//  Movies.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import Foundation

struct MovieResponse: Decodable {
    let movieResults: [Movie]
    let results: Int
    let totalResults: String
    let status: String
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case results
        case totalResults = "Total_results"
        case status
        case statusMessage = "status_message"
    }
}

struct Movie: Decodable {
    let title: String
    let year: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey{
        case title
        case year
        case imdbID = "imdb_id"
    }
}
