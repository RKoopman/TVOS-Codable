//
//  LastWatched.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

public enum CWPlaybackType: String, Codable {
    case vod
    case lookback
    case dvr
}

public class LastWatched: NSObject, Codable {
    
    public var airingID: String?
    public var duration: Int?
    public var endDateTime: String?
    public var genre: Genre?
    public var lastOffset: Int?
    public var network: Network?
    public var program: Program?
    public var qualifiers: [String]?
    public var startDateTime: String?
    public var startDate:Date?
    public var endDate:Date?
    public var sourceType:SourceType = .unknown
    public var match: Match?
    public var playbackType: CWPlaybackType?
    
    
    enum CodingKeys: String, CodingKey {
        case airingID = "airingId"
        case duration = "duration"
        case endDateTime = "endDateTime"
        case genre = "genre"
        case lastOffset = "lastOffset"
        case network = "network"
        case program = "program"
        case qualifiers = "qualifiers"
        case sourceType = "sourceType"
        case startDateTime = "startDateTime"
        case match = "match"
        case playbackType = "playbackType"
    }
    
    init(airingID: String?, duration: Int?, endDateTime: String?, genre: Genre?, lastOffset: Int?, network: Network?, program: Program?, qualifiers: [String]?, sourceType: SourceType, startDateTime: String?, match: Match?) {
        self.airingID = airingID
        self.duration = duration
        self.endDateTime = endDateTime
        self.genre = genre
        self.lastOffset = lastOffset
        self.network = network
        self.program = program
        self.qualifiers = qualifiers
        self.sourceType = sourceType
        self.startDateTime = startDateTime
        self.match = match
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airingID = try values.decodeIfPresent(String.self, forKey: .airingID)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        endDateTime = try values.decodeIfPresent(String.self, forKey: .endDateTime)
        genre = try values.decodeIfPresent(Genre.self, forKey: .genre)
        lastOffset = try values.decodeIfPresent(Int.self, forKey: .lastOffset)
        network = try values.decodeIfPresent(Network.self, forKey: .network)
        program = try values.decodeIfPresent(Program.self, forKey: .program)
        qualifiers = try values.decodeIfPresent([String].self, forKey: .qualifiers)
        sourceType = try values.decodeIfPresent(SourceType.self, forKey: .sourceType) ?? .unknown
        startDateTime = try values.decodeIfPresent(String.self, forKey: .startDateTime)
        match = try values.decodeIfPresent(Match.self, forKey: .match)
//        startDate = FuboDateStyler.getDate(forString: startDateTime)
//        endDate = FuboDateStyler.getDate(forString: endDateTime)
        playbackType = try values.decodeIfPresent(CWPlaybackType.self, forKey: .playbackType)
    }
    
    public var isLive:Bool {
        guard isStream, let start = startDate, let end = endDate else {
            return false
        }
        
        let current = Date()
        return (start <= current && end > current)
    }
    
    var isLookback: Bool {
        return sourceType == .lookback
    }
    
    var playheadPercentage: Float {
        
        guard let duration = duration, let lastOffset = lastOffset, duration > 0, lastOffset > 0 else {
            return 0.0
        }
        return Float(lastOffset)/Float(duration)
    }
    
    var contentType:ContentType {
        return self.program?.contentType ?? .other
    }
    
    var isStream: Bool {
        return sourceType == .live
    }
}


//MARK: - Generate subtitle
extension LastWatched {
    
    public func generateSubtitle() -> String {
        
        switch contentType {
        case .episode, .series_episode:
            return generateEpisodeSubtitle()
        case .movie:
            return generateMovieSubtitle()
        case .sports_event:
            return generateSportsEventSubtitle()
        default:
            return ""
        }
    }
    
    private func generateEpisodeSubtitle() -> String {
        
        var resultString = ""
        
        if let seriesNumber = program?.seasonNumber {
            resultString += "S\(seriesNumber)"
        }
        if let episodeNumber = program?.episodeNumber {
            resultString += (resultString.isEmpty ? "" : ", ") + "E\(episodeNumber)"
        }
        if let episodeName = program?.episodeTitle, !episodeName.isEmpty  {
            resultString += (resultString.isEmpty ? "" : " | ") + "\(episodeName)"
        }
        return resultString
    }
    
    private func generateMovieSubtitle() -> String {
        
        var resultString = ""
        
        if let movieYear = program?.year {
            resultString += "\(movieYear)"
        }
        //TODO: - Needed add rating
        /**/
        return resultString
    }
    
    private func generateSportsEventSubtitle() -> String {
        return match?.league?.leagueName ?? ""
    }
}

