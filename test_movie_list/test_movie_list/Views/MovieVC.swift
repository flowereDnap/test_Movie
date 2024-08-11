//
//  MovieViewController.swift
//  test_movie_list
//
//  Created by mac on 11.08.2024.
//

import Foundation
import UIKit

class MovieVC: UIViewController {
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var countryLabel: UILabel?
    @IBOutlet var genreLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var ratingLabel: UILabel?
    
    @IBOutlet var trailerButton: UIButton?
    @IBOutlet var imageButton: UIButton?
    
    @IBAction func trailerButtonTapped(_ sender: UIButton) {
        print("Трейлерная кнопка нажата!")
    }
    @IBAction func imageButtonTrapped(_ sender:UIButton) {
        print("image")
    }
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel?.text = movie?.title
        countryLabel?.text = movie?.country
        genreLabel?.text = movie?.genres.map { $0.name }.joined(separator: ", ")
        descriptionLabel?.text = movie?.overview
        ratingLabel?.text = String(movie?.vote_average ?? 0)
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
