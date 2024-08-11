//
//  MovieClass.swift
//  test_movie_list
//
//  Created by mac on 31.07.2024.
//

import Foundation

struct Movie: Codable {
    let title: String
    let genres: [Genre]
    let release_date: String
    let vote_average: Double
    let overview: String
    let poster_path: String
}

struct Genre: Codable {
    let id: Int
    let name: String
}
