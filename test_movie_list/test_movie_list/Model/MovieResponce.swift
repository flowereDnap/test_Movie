//
//  MovieResponce.swift
//  test_movie_list
//
//  Created by mac on 06.08.2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
