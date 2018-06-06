//
//  Match.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation
typealias Matches = [Match]

public struct Match: Codable {
    let tmsID: String?
    let matchID: String?
    let shortDescription: String?
    let longDescription: String?
    let sportType: String?
    let title: String?
    let homeTeam: Team?
    let awayTeam: Team?
    let teamTemplate: String?
    let airings: [Airing]?
    let league: League?
    let sport: Sport?
    
    enum CodingKeys: String, CodingKey {
        case tmsID = "tmsId"
        case matchID = "matchId"
        case shortDescription = "shortDescription"
        case longDescription = "longDescription"
        case sportType = "sportType"
        case title = "title"
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
        case teamTemplate = "teamTemplate"
        case airings = "airings"
        case league = "league"
        case sport = "sport"
    }
}


// MARK: Convenience initializers

extension Match {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Match.self, from: data) else { return nil }
        self = me
    }
    
    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }
    
    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }
    
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func promotedMatchesTask(with url: URL, completionHandler: @escaping (Matches?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
//    func filteredMatchesTask(with url: URL, completionHandler: @escaping (Matches?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
    
    func liveAndUpcommingMatchesTask(with url: URL, completionHandler: @escaping (Matches?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func recentMatchesTask(with url: URL, completionHandler: @escaping (Matches?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
