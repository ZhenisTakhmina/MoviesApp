//
//  Movies.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import Foundation

struct MovieResponse: Codable {
    let movieResults: [Movie]
    let results: Int
    let totalResults: Int
    let status: String
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case results
        case totalResults = "Total_results"
        case status
        case status = "status_message"
    }
}

struct Movie: Codable {
    let title: String
    let year: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey{
        case title
        case year
        case imdbID = "imdb_id"
    }
}
