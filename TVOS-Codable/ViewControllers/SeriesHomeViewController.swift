//
//  SeriesHomeViewController.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import UIKit

class SeriesHomeViewController: UIViewController {
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view control loaded")
        self.view.backgroundColor = UIColor.green
        
    }
    
    // RESPONSE FUNTIOINS (reload)
    var responsePromotedSeries: Series? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var responseGenreSeries: Series? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var responseLiveAndUpcomingSeries: Series? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var responsePopularSeries: Series? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var responseRecentSeries: Series? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    // FETCH DATA FUNCTIONS
    
    @objc func fetchPromotedSeries(_ sender: Any) {
        let serTask = URLSession.shared.promotedSeriesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v1/tv/promoted?" + "contentType=promoted_series")!) { proSeries, response, error in
            if let proSeries = proSeries {
                self.responsePromotedSeries = proSeries
                print("Promoted Series API call")
            }
        }
        serTask.resume()
    }
    
    @objc func fetchGenreSeries(_ sender: Any) {
        let serTask = URLSession.shared.genreSeriesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v2/series/genres")!) { genreSeries, response, error in
            if let genreSeries = genreSeries {
                self.responsePopularSeries = genreSeries
                print("Genres Series API call")
            }
        }
        serTask.resume()
    }
    
    @objc func fetchLiveAndUpcomingSeries(_ sender: Any) {
        let serTask = URLSession.shared.liveAndUpcomingSeriesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v3/series/live")!) { liveAndUpcomingSeries, response, error in
            if let liveAndUpcomingSeries = liveAndUpcomingSeries {
                self.responseLiveAndUpcomingSeries = liveAndUpcomingSeries
                print("Live and Upcoming Series API call")
            }
        }
        serTask.resume()
    }
    
    @objc func fetchPopularSeries(_ sender: Any) {
        let serTask = URLSession.shared.popularSeriesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v1/tv/promoted?" + "contentType=popular_serie")!) { popSeries, response, error in
            if let popSeries = popSeries {
                self.responsePopularSeries = popSeries
                print("Popular Series API call")
            }
        }
        serTask.resume()
    }
    
    @objc func fetchRecentSeries(_ sender: Any) {
        let serTask = URLSession.shared.recentSeriesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v1/series/recent")!) { recentSeries, response, error in
            if let recentSeries = recentSeries {
                self.responseRecentSeries = recentSeries
                print("Recent Series API call")
            }
        }
        serTask.resume()
    }
    
    // COLLECTION VIEW METHODS
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
