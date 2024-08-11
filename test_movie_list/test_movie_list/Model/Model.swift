//
//  Model.swift
//  test_movie_list
//
//  Created by mac on 31.07.2024.
//

import Foundation

class Model {
    
    var movies: [Movie]
    
    var loadingState: String = ""
    
    var loadingManager: String = ""
    
    func load() {
        //TODO
    }
    
    init(movies: [Movie], loadingState: String, loadingManager: String) {
        self.movies = movies
        self.loadingState = loadingState
        self.loadingManager = loadingManager
    }
    
}
