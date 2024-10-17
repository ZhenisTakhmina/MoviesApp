//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import Foundation

struct MovieDetail: Codable {
    let title: String?
    let description: String?
    let year: String?
    let releaseDate: String?
    let imdbID: String?
    let imdbRating: String?
    let rated: String?
    let runtime: Int?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case year
        case releaseDate = "release_date"
        case imdbID = "imdb_id"
        case imdbRating = "imdb_rating"
        case rated
        case runtime
        case genres
    }
}
