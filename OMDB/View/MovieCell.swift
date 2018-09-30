//
//  MovieCell.swift
//  OMDB
//
//  Created by Kunal Tyagi on 30/09/18.
//  Copyright © 2018 Kunal Tyagi. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieType: UILabel!
    
    func setupView(movie: Movie) {
        self.movieImage.image = movie.image
        self.movieTitle.text = movie.title
        self.movieYear.text = movie.year
        self.movieType.text = movie.type
    }

}
