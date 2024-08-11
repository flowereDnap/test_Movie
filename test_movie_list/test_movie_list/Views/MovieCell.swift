//
//  MovieCell.swift
//  test_movie_list
//
//  Created by mac on 30.07.2024.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var genreLable: UILabel!
    @IBOutlet var ratingLable: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    func configure(title: String, genre: String, rating: String, imageName: String) {
        titleLable.text = title
        titleLable.layer.cornerRadius = 8.0
        titleLable.layer.masksToBounds = true
        titleLable.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.font = UIFont.systemFont(ofSize: 14)
        titleLable.textColor = .white
        
        genreLable.text = genre
        genreLable.layer.cornerRadius = 20.0
        genreLable.layer.masksToBounds = true
        genreLable.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        
        ratingLable.text = rating
        ratingLable.layer.cornerRadius = 20.0
        ratingLable.layer.masksToBounds = true
        ratingLable.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        
        bgImage.image = UIImage(named: imageName)
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        bgImage.contentMode = .scaleAspectFill
        bgImage.layer.cornerRadius = 8
        bgImage.layer.masksToBounds = true
        
        bgImage.layer.shadowColor = UIColor.black.cgColor
        bgImage.layer.shadowOpacity = 0.5
        bgImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        bgImage.layer.shadowRadius = 4
        bgImage.layer.masksToBounds = false
        bgImage.backgroundColor = .clear
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
