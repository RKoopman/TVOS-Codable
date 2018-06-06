//
//  ViewController.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import UIKit

class MoviesHomeViewController: UIViewController {

    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view control loaded")
        self.view.backgroundColor = UIColor.blue
        
    }
    
// RESPONSE FUNTIOINS (reload)
    var responsePromotedMovies: Movies? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var responseGenreMovies: Movies? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var responseLiveAndUpcomingMovies: Movies? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var responsePopularMovies: Movies? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    var responseRecentMovies: Movies? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
// FETCH DATA FUNCTIONS
    
    @objc func fetchPromotedMovies(_ sender: Any) {
        let movTask = URLSession.shared.promotedMoviesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v1/tv/promoted?" + "contentType=promoted_movie")!) { proMovies, response, error in
            if let proMovies = proMovies {
                self.responsePromotedMovies = proMovies
                print("Promoted Movies API call")
            }
        }
        movTask.resume()
    }

    @objc func fetchGenreMovies(_ sender: Any) {
        let movTask = URLSession.shared.genreMoviesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v3/movies/genres")!) { genreMovies, response, error in
            if let genreMovies = genreMovies {
                self.responsePopularMovies = genreMovies
                print("Genres Movies API call")
            }
        }
        movTask.resume()
    }
    
    @objc func fetchLiveAndUpcomingMovies(_ sender: Any) {
        let movTask = URLSession.shared.liveAndUpcomingMoviesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v1/movies/live")!) { liveAndUpcomingMovies, response, error in
            if let liveAndUpcomingMovies = liveAndUpcomingMovies {
                self.responseLiveAndUpcomingMovies = liveAndUpcomingMovies
                print("Live and Upcoming Movies API call")
            }
        }
        movTask.resume()
    }
    
    @objc func fetchPopularMovies(_ sender: Any) {
        let movTask = URLSession.shared.popularMoviesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v1/tv/promoted?" + "contentType=popular_movie")!) { popMovies, response, error in
            if let popMovies = popMovies {
                self.responsePopularMovies = popMovies
                print("Popular Movies API call")
            }
        }
        movTask.resume()
    }
    
    @objc func fetchRecentMovies(_ sender: Any) { // take out recent??
        let movTask = URLSession.shared.recentMoviesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v1/movies/recent")!) { recentMovies, response, error in
            if let recentMovies = recentMovies {
                self.responseRecentMovies = recentMovies
                print("Recent Movies API call")
            }
        }
        movTask.resume()
    }
    
// COLLECTION VIEW METHODS
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

