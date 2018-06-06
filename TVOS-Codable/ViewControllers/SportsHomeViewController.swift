//
//  SportsHomeViewController.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import UIKit

class SportsHomeViewController: UIViewController {
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view control loaded")
        self.view.backgroundColor = UIColor.orange
        
    }
    
    // RESPONSE FUNTIOINS (reload)
    var responsePromotedMatches: Matches? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
//    var responseFilteredMatches: Matches? {
//        didSet {
//            DispatchQueue.main.async {
//                self.collectionView?.reloadData()
//            }
//        }
//    }
    
    var responseLiveAndUpcomingMatches: Matches? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var responseRecentMatches: Matches? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    // FETCH DATA FUNCTIONS
    
    @objc func fetchPromotedMatches(_ sender: Any) {
        let matchTask = URLSession.shared.promotedMatchesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v4/sports/promoted")!) { proMatches, response, error in
            if let proMatches = proMatches {
                self.responsePromotedMatches = proMatches
                print("Promoted Matches API call")
            }
        }
        matchTask.resume()
    }
    
//    @objc func fetchFilteredMatches(_ sender: Any) {
//        let matchTask = URLSession.shared.filteredMatchesTask(with: URL(string: "???")!) { filtMatches, response, error in
//            if let filtMatches = filtMatches {
//                self.responseFilteredMatches = filtMatches
//                print("Filtered Matches API call")
//            }
//        }
//        matchTask.resume()
//    }
    
    @objc func fetchLiveAndUpcomingMatches(_ sender: Any) {
        let matchTask = URLSession.shared.liveAndUpcommingMatchesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v3/series/live")!) { liveAndUpcomingMatches, response, error in
            if let liveAndUpcomingMatches = liveAndUpcomingMatches {
                self.responseLiveAndUpcomingMatches = liveAndUpcomingMatches
                print("Live and Upcoming Matches API call")
            }
        }
        matchTask.resume()
    }
    
    
    @objc func fetchRecentMatches(_ sender: Any) {
        let matchTask = URLSession.shared.recentMatchesTask(with: URL(string: "https://qa-api.fubo.tv/v3/kgraph/v1/matches/recent")!) { recentMatches, response, error in
            if let recentMatches = recentMatches {
                self.responseRecentMatches = recentMatches
                print("Recent Matches API call")
            }
        }
        matchTask.resume()
    }
    
    func fetchData() { // not sure which funch it calls wihtin fuboTV app
        
        
    }
    
    
    // COLLECTION VIEW METHODS
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
