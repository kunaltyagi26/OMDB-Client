//
//  DetailVC.swift
//  OMDB
//
//  Created by Kunal Tyagi on 30/09/18.
//  Copyright © 2018 Kunal Tyagi. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    var name = ""
    var image = UIImage()
    var type = ""
    var year = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieName.text = name
        self.movieImage.image = image
        self.movieType.text = type
        self.movieYear.text = year
    }
    
    func getContent(movie: Movie) {
        self.name = movie.title!
        self.image = movie.image!
        self.type = movie.type!
        self.year = movie.year!
    }
}
