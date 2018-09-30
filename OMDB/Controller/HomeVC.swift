//
//  ViewController.swift
//  OMDB
//
//  Created by Kunal Tyagi on 30/09/18.
//  Copyright © 2018 Kunal Tyagi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeVC: UIViewController {

    var moviesArray: [Movie] = []
    var pageNumber = 1
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        loadData(pageNumber)
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    
    func loadData(_ pageNumber: Int) {
        let url = "https://www.omdbapi.com/?s=Batman&page=\(pageNumber)&apikey=eeefc96f"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                guard let movies = response.result.value as? [String:AnyObject] else { return }
                guard let allMovies = movies["Search"] as? NSArray else { return }
                for movie in allMovies {
                    var mov = Movie()
                    
                    mov.title = (movie as AnyObject).value(forKeyPath: "Title") as? String
                    mov.type = (movie as AnyObject).value(forKeyPath: "Type") as? String
                    mov.imdbId = (movie as AnyObject).value(forKeyPath: "imdbID") as? String
                    
                    let date = Date()
                    let calendar = Calendar.current
                    let currentYear = calendar.component(.year, from: date)
                    
                    let yr = (movie as AnyObject).value(forKeyPath: "Year") as? String
                    let index = yr?.index((yr?.startIndex)!, offsetBy: 4)
                    let formattedYr = yr?.substring(to: index!)
                    let year = Int(formattedYr!)
                    
                    mov.year = "\(currentYear - year!) years ago"
                    
                    guard let imageUrl = (movie as AnyObject).value(forKeyPath: "Poster") as? String else { return }
                    Alamofire.request(imageUrl).responseImage { (response) in
                        if response.result.error == nil {
                            guard let img = response.result.value else {return}
                            mov.image = img
                            
                            self.moviesArray.append(mov)
                            
                            //self.activityIndicator.stopAnimating()
                            //self.activityIndicator.isHidden = true
                            
                            self.movieCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = moviesArray[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        cell.setupView(movie: movie)
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - offset) <= 0 {
            
            pageNumber += 1
            loadData(pageNumber)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailView") as? DetailVC else { return }

        detailVC.getContent(movie: moviesArray[indexPath.row])
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
        
}

