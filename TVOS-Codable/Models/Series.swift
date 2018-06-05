//
//  Series.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

typealias Series = [Serie]

open class Serie: Codable {
    let tmsID: String?
    let seriesID: Int?
    let seriesTitle: String?
    let episodeTitle: String?
    let shortDescription: String?
    let longDescription: String?
    let thumbnailURL: String?
    let letterImageURL: String?
    let seasonNumber: Int?
    let episodeNumber: Int?
    let airings: [Airing]?
    let seriesDescription: String?
    let seriesBannerURL: String?
    let episodes: [Episode]?
    let seriesLetterImageURL: String?
    var analitycsPage: String?
    
    enum CodingKeys: String, CodingKey {
        case tmsID = "tmsId"
        case seriesID = "seriesId"
        case seriesTitle = "seriesTitle"
        case episodeTitle = "episodeTitle"
        case shortDescription = "shortDescription"
        case longDescription = "longDescription"
        case thumbnailURL = "thumbnailUrl"
        case letterImageURL = "letterImageUrl"
        case seasonNumber = "seasonNumber"
        case episodeNumber = "episodeNumber"
        case airings = "airings"
        case seriesDescription = "seriesDescription"
        case seriesBannerURL = "seriesBannerUrl"
        case episodes = "episodes"
        case seriesLetterImageURL = "seriesLetterImageUrl"
    }
    
    init(tmsID: String?, seriesID: Int?, seriesTitle: String?, episodeTitle: String?, shortDescription: String?, longDescription: String?, thumbnailURL: String?, letterImageURL: String?, seasonNumber: Int?, episodeNumber: Int?, airings: [Airing]?, seriesDescription: String?, seriesBannerURL: String?, episodes: [Episode]?, seriesLetterImageURL: String?) {
        self.tmsID = tmsID
        self.seriesID = seriesID
        self.seriesTitle = seriesTitle
        self.episodeTitle = episodeTitle
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.thumbnailURL = thumbnailURL
        self.letterImageURL = letterImageURL
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
        self.airings = airings
        self.seriesDescription = seriesDescription
        self.seriesBannerURL = seriesBannerURL
        self.episodes = episodes
        self.seriesLetterImageURL = seriesLetterImageURL
    }
}

open class Episode: Codable {
    let tmsID: String?
    let episodeTitle: String?
    let shortDescription: String?
    let longDescription: String?
    let thumbnailURL: String?
    let letterImageURL: String?
    let seasonNumber: Int?
    let episodeNumber: Int?
    let airings: [Airing]?
    let originalAiringDate: String?
    let episodeDuration: Int?
    
    enum CodingKeys: String, CodingKey {
        case tmsID = "tmsId"
        case episodeTitle = "episodeTitle"
        case shortDescription = "shortDescription"
        case longDescription = "longDescription"
        case thumbnailURL = "thumbnailUrl"
        case letterImageURL = "letterImageUrl"
        case seasonNumber = "seasonNumber"
        case episodeNumber = "episodeNumber"
        case airings = "airings"
        case originalAiringDate = "originalAiringDate"
        case episodeDuration = "episodeDuration"
    }
    
    init(tmsID: String?, episodeTitle: String?, shortDescription: String?, longDescription: String?, thumbnailURL: String?, letterImageURL: String?, seasonNumber: Int?, episodeNumber: Int?, airings: [Airing]?, originalAiringDate: String?, episodeDuration: Int?) {
        self.tmsID = tmsID
        self.episodeTitle = episodeTitle
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.thumbnailURL = thumbnailURL
        self.letterImageURL = letterImageURL
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
        self.airings = airings
        self.originalAiringDate = originalAiringDate
        self.episodeDuration = episodeDuration
    }
    
    public var isLive:Bool {
        guard let airing = airings?.first else {
            return false
        }
        
        guard let start = airing.startDate, let end = airing.endDate else {
            return false
        }
        
        let current = Date()
        
        return (start <= current && end > current && airing.sourceType == .live)
    }
    
    public var isLookback:Bool {
        guard let airing = airings?.first else {
            return false
        }
        
        return airing.sourceType == .lookback
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
    
}

extension Episode:Recordable {
    public var airingId: String? {
        return airings?.first?.airingId
    }
}

extension Episode:StationPlayable {
    public var stationId:String? {
        guard let networkId = airings?.first?.networkID else {
            return nil
        }
        return String(networkId)
    }
}

// MARK: - Equatable Conformance
extension Episode: Equatable {}
public func == (lhs:Episode, rhs:Episode) -> Bool {
    return lhs.tmsID == rhs.tmsID
}

// MARK: Convenience initializers

extension Serie {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Serie.self, from: data)
        self.init(tmsID: me.tmsID, seriesID: me.seriesID, seriesTitle: me.seriesTitle, episodeTitle: me.episodeTitle, shortDescription: me.shortDescription, longDescription: me.longDescription, thumbnailURL: me.thumbnailURL, letterImageURL: me.letterImageURL, seasonNumber: me.seasonNumber, episodeNumber: me.episodeNumber, airings: me.airings, seriesDescription: me.seriesDescription, seriesBannerURL: me.seriesBannerURL, episodes: me.episodes, seriesLetterImageURL: me.seriesLetterImageURL)
    }
    
    convenience init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }
    
    convenience init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}

extension Episode {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Episode.self, from: data)
        self.init(tmsID: me.tmsID, episodeTitle: me.episodeTitle, shortDescription: me.shortDescription, longDescription: me.longDescription, thumbnailURL: me.thumbnailURL, letterImageURL: me.letterImageURL, seasonNumber: me.seasonNumber, episodeNumber: me.episodeNumber, airings: me.airings, originalAiringDate: me.originalAiringDate, episodeDuration: me.episodeDuration)
    }
    
    convenience init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }
    
    convenience init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}

extension Array where Element == Series.Element {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Series.self, from: data) else { return nil }
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
