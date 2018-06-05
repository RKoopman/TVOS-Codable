//
//  Movie.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

typealias Movies = [Movie]

open class Movie: Codable {
    
    public var tmsID: String?
    public var movieID: String?
    public var title: String?
    public var shortDescription: String?
    public var longDescription: String?
    public var posterImageURL: String?
    public var genres: [Genre]?
    public var actors: [Actor]?
    public var movieDuration: Int?
    public var releaseYear: Int?
    public var rating: String?
    public var airings: [Airing]?
    public var letterImageURL: String?
    public var analitycsPage: String?
    
    enum CodingKeys: String, CodingKey {
        case tmsID = "tmsId"
        case movieID = "movieId"
        case title = "title"
        case shortDescription = "shortDescription"
        case longDescription = "longDescription"
        case posterImageURL = "posterImageUrl"
        case genres = "genres"
        case movieDuration = "movieDuration"
        case releaseYear = "releaseYear"
        case rating = "rating"
        case airings = "airings"
        case actors = "actors"
        case letterImageURL = "letterImageUrl"
        case analitycsPage
    }
    
    init(tmsID: String?, movieID: String?, title: String?, shortDescription: String?, longDescription: String?, posterImageURL: String?, genres: [Genre]?, actors: [Actor]?, movieDuration: Int?, releaseYear: Int?, rating: String?, airings: [Airing]?, letterImageURL: String?) {
        self.tmsID = tmsID
        self.movieID = movieID
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.posterImageURL = posterImageURL
        self.genres = genres
        self.movieDuration = movieDuration
        self.releaseYear = releaseYear
        self.rating = rating
        self.airings = airings
        self.actors = actors
        self.letterImageURL = letterImageURL
    }
    
    var keywords:String {
        var k = (self.title ?? "") + (self.airings?.first?.networkName ?? "")
        for a in self.actors ?? [Actor]() {
            k = k + (a.actorName ?? "")
        }
        for g in self.genres ?? [Genre]() {
            k = k + (g.genreName ?? "")
        }
        return k
    }
    
    public var isLive:Bool {
        
        guard let airing = airings?.first, let start = airing.startDate, let end = airing.endDate else {
            return false
        }
        
        let current = Date()
        
        return (start <= current && end > current && sourceType == .live)
    }
    
    public var isLookback:Bool {
        guard let airing = airings?.first else {
            return false
        }
        
        guard airing.sourceType == .lookback else {
            return false
        }
        
        return true
    }
    
    public var sourceType:SourceType {
        guard let airing = airings?.first else {
            return .unknown
        }
        
        return airing.sourceType
    }
    
    var isRecordable: Bool {
        guard let airing = airings?.first else {
            return false
        }
        
        return airing.allowDVR ?? false
    }
    
    var subtitle:String {
        var textContent = ""
        if let year = self.releaseYear, year != 0 {
            textContent = "\(year)"
        }
        if let rating = self.rating, !rating.isEmpty, !textContent.isEmpty {
            textContent = textContent + " | \(rating)"
        } else if let rating = self.rating, !rating.isEmpty, !textContent.isEmpty {
            textContent = textContent + "\(rating)"
        }
        return textContent
    }
}

extension Movie:Recordable {
    public var airingId: String? {
        return airings?.first?.airingId
    }
}

extension Movie:StationPlayable {
    public var stationId:String? {
        guard let networkId = airings?.first?.networkID else {
            return nil
        }
        return String(networkId)
    }
}

// MARK: Convenience initializers

extension Movie {
    convenience init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Movie.self, from: data) else { return nil }
        self.init(tmsID: me.tmsID, movieID: me.movieID, title: me.title, shortDescription: me.shortDescription, longDescription: me.longDescription, posterImageURL: me.posterImageURL, genres: me.genres, actors: me.actors, movieDuration: me.movieDuration, releaseYear: me.releaseYear, rating: me.rating, airings: me.airings, letterImageURL: me.letterImageURL)
    }
    
    convenience init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }
    
    convenience init?(fromURL url: String) {
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

public struct Actor: Codable {
    let actorName: String?
}

public struct Availability: Codable {
    let startDateTime, endDateTime: String?
}
