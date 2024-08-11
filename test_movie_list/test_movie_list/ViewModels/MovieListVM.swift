//
//  MovieListVM.swift
//  test_movie_list
//
//  Created by mac on 31.07.2024.
//

import Foundation

enum sortType {
    case nameAlfabetic
    case nameReversed
    case yearNewest
    case yearReversed
    case ratingBig
    case ratingReverced
}

class MovieListVM {
    
    var moviesList: [Movie] = []
    
    var sortType: sortType = .ratingBig
    
    func sort() {
        switch sortType {
        case .nameAlfabetic:
            //TODO
            return
        case .nameReversed:
            //TODO
            return
        case .yearNewest:
            //TODO
            return
        case .yearReversed:
            //TODO
            return
        case .ratingBig:
            //TODO
            return
        case .ratingReverced:
            //TODO
            return
        }
    }
    
}
