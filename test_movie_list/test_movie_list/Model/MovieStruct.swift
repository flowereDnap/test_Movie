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
    
    init(from ratedMovie: RatedMovie) {
            self.title = ratedMovie.title
            self.release_date = ratedMovie.releaseDate
            self.vote_average = ratedMovie.voteAverage
            self.overview = ratedMovie.overview
            self.poster_path = ratedMovie.posterPath ?? ""
            
            // Map genre IDs to Genre objects
            self.genres = ratedMovie.genreIds.compactMap { genreId in
                if let genreName = Genre.genreMapping[genreId] {
                    return Genre(id: genreId, name: genreName)
                }
                return nil
            }
        }
}

struct Genre: Codable {
    let id: Int
    let name: String
    
    static let genreMapping: [Int: String] = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]

}

