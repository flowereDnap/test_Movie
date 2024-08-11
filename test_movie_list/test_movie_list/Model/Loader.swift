//
//  Loader.swift
//  test_movie_list
//
//  Created by mac on 06.08.2024.
//

import Foundation

import Alamofire

class MovieService {
    static let shared = MovieService()
    private init() {}
    
    func fetchMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let apiKey = "YOUR_API_KEY"
        let url = "https://api.themoviedb.org/3/movie/popular"
        let parameters: [String: Any] = [
            "api_key": apiKey,
            "language": "en-US",
            "page": page
        ]
        
        AF.request(url, parameters: parameters).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
