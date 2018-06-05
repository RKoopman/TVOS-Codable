//
//  Airing.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

public enum Rating: String, Codable {
    case a = "A"
    case b = "B"
    case b15 = "B15"
    case c = "C"
    case family = "Family"
    case g = "G"
    case k12 = "K12"
    case k16 = "K16"
    case l = "L"
    case m = "M"
    case ma15 = "MA 15+"
    case nc = "NC"
    case pg = "PG"
    case pg13 = "PG-13"
    case r = "R"
    case rating13 = "13"
    case s = "S"
    case the0 = "0"
    case the10 = "-10"
    case the1012PG = "10-12 PG"
    case the12 = "12"
    case the13 = "13+"
    case the13M = "13M"
    case the14 = "14"
    case the14A = "14A"
    case the15 = "15"
    case the16 = "16"
    case the18 = "18"
    case the18A = "18A"
    case the6 = "6"
    case the7 = "7"
    case tousPublics = "Tous publics"
    case tp = "TP"
    case tv14 = "TV14"
    case tvg = "TVG"
    case tvma = "TVMA"
    case tvpg = "TVPG"
    case tvy = "TVY"
    case tvy7 = "TVY7"
    case u = "U"
}

public enum TeamTemplate: String, Codable {
    case awayAtHome = "awayAtHome"
    case homeVsAway = "homeVsAway"
    case noTeams = "noTeams"
}

public enum ContentType: String, Codable {
    case movie = "movie"
    case episode = "episode"
    case match = "match"
    case other = "other"
    case sports_event = "sports_event"
    case series_episode = "series_episode"
}

public class Airing: NSObject, Codable, Recordable {
    public var tmsId: String?
    public var airingId: String?
    public var sourceType: SourceType = .unknown
    public var contentType: ContentType = .other
    public var title: String?
    public var episodeName: String?
    public var seasonNumber: Int?
    public var episodeNumber: Int?
    public var releaseYear: Int?
    public var rating: String?
    public var programDescription: String?
    public var letterImageUrl: String?
    public var startDateTime: String?
    public var endDateTime: String?
    public var lookbackStartDateTime: String?
    public var lookbackEndDateTime: String?
    public var adjustedVisualAiringStartDate: Date?
    public var adjustedVisualAiringEndDate: Date?
    public var networkID: Int?
    public var networkName: String?
    public var slug: String?
    public var networkLogoThumbnailURL: String?
    public var networkLogoOnWhiteURL: String?
    public var networkLogoOnDarkURL: String?
    public var streamURL: String?
    public var allowDVR: Bool?
    public var displayName: String?
    public var type: String?
    public var category: String?
    public var lastOffset: Int?
    public var duration: Int?
    public var seriesID: Int?
    public var seriesName: String?
    public var isNew: Bool?
    public var homeTeam: Team?
    public var awayTeam: Team?
    public var teamTemplate: TeamTemplate = .noTeams
    public var playbackType: String?
    public var networkOwner: String?
    public var fullStartover: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case airingId
        case tmsId
        case sourceType
        case title
        case episodeName
        case seasonNumber
        case episodeNumber
        case releaseYear
        case rating
        case programDescription = "description"
        case letterImageUrl
        case startDateTime
        case endDateTime
        case lookbackStartDateTime
        case lookbackEndDateTime
        case networkID = "networkId"
        case networkName = "networkName"
        case slug = "slug"
        case networkLogoThumbnailURL = "networkLogoThumbnailUrl"
        case networkLogoOnWhiteURL = "networkLogoOnWhiteUrl"
        case networkLogoOnDarkURL = "networkLogoOnDarkUrl"
        case streamURL = "streamUrl"
        case allowDVR = "allowDVR"
        case displayName = "displayName"
        case type = "type"
        case category = "category"
        case duration = "duration"
        case lastOffset = "lastOffset"
        case seriesID = "seriesId"
        case seriesName, isNew
        case contentType
        case homeTeam
        case awayTeam
        case teamTemplate
        case playbackType = "playbackType"
        case networkOwner = "networkOwner"
        case fullStartover = "fullStartOver"
    }
    
    public var startDate: Date? {
        didSet {
            if self.startDateTime == nil {
//                self.startDateTime = startDate?.RFC3339()
            }
        }
    }
    
    public var endDate: Date? {
        didSet {
            if self.endDateTime == nil {
//                self.endDateTime = endDate?.RFC3339()
            }
        }
    }
    
    public var isLookback: Bool {
        return sourceType == .lookback
    }
    
    public var isLive:Bool {
        guard let start = startDate, let end = endDate else {
            return false
        }
        
        let current = Date()
        return (start <= current && end > current)
    }
    
    public var programMinutesVisable: Int? {
        guard var start = startDate, var end = endDate else {
            return nil
        }
        
        if let now = adjustedVisualAiringStartDate, start < now {
            start = now
        }
        
        if let visualEnd = adjustedVisualAiringEndDate, end > visualEnd {
            end = visualEnd
        }
        
        let components = Calendar.current.dateComponents([.minute], from: start, to: end)
        let lengthInMins = components.minute ?? 0
        return lengthInMins
    }
    
    var isRecordable: Bool {
        guard let _ = self.airingId else {
            return false
        }
        
        return self.allowDVR ?? false
    }
    
    public var playheadPercentage: Float {
        guard let duration = duration,
            let lastOffset = lastOffset,
            duration > 0,
            lastOffset > 0,
            isLive == false
            else {
                return 0.0
        }
        
        return Float(lastOffset)/Float(duration)
    }
    
    public var shortDescripitionInterstitial: String {
        switch contentType {
        case .episode:
            var textContent = ""
            if let seasonNum = self.seasonNumber, seasonNum != 0 {
                textContent = "S\(seasonNum)"
            }
            if let episodeNum = self.episodeNumber, episodeNum != 0, !textContent.isEmpty {
                textContent = textContent + ", EP\(episodeNum)"
            } else if let episodeNum = self.episodeNumber, episodeNum != 0 {
                textContent = textContent + "EP\(episodeNum)"
            }
            if let episodeTitle = self.episodeName, !episodeTitle.isEmpty, !textContent.isEmpty {
                textContent = textContent + " | \(episodeTitle)"
            } else if let episodeTitle = self.episodeName, !episodeTitle.isEmpty {
                textContent = textContent + "\(episodeTitle)"
            }
            
            if let rating = self.rating, !rating.isEmpty, !textContent.isEmpty {
                textContent = textContent + " | \(rating)"
            } else if let rating = self.rating, !rating.isEmpty {
                textContent = "\(rating)"
            }
            
            if let year = self.releaseYear, year != 0, !textContent.isEmpty {
                textContent = textContent + " | \(year)"
            } else if let year = self.releaseYear, year != 0 {
                textContent = "\(year)"
            }
            
            if let min = self.programMinutesVisable, min != 0, !textContent.isEmpty {
                textContent = textContent + " | \(min) min"
            } else if let min = self.programMinutesVisable, min != 0 {
                textContent = "\(min) min"
            }
            
            return textContent
        case .match:
            return self.title ?? ""
        case .movie:
            var textContent = ""
            if let year = self.releaseYear, year != 0 {
                textContent = "\(year)"
            }
            
            if let rating = self.rating, !rating.isEmpty, !textContent.isEmpty {
                textContent = textContent + " | \(rating)"
            } else if let rating = self.rating, !rating.isEmpty, !textContent.isEmpty {
                textContent = textContent + "\(rating)"
            }
            
            if let min = self.programMinutesVisable, min != 0, !textContent.isEmpty {
                textContent = textContent + " | \(min) min"
            } else if let min = self.programMinutesVisable, min != 0 {
                textContent = "\(min) min"
            }
            
            return textContent
        default:
            return self.programDescription ?? ""
        }
    }
    
    public var shortDescripitionWristband: String {
        switch contentType {
        case .episode:
            var textContent = ""
            if let seasonNum = self.seasonNumber, seasonNum != 0 {
                textContent = "S\(seasonNum)"
            }
            if let episodeNum = self.episodeNumber, episodeNum != 0, !textContent.isEmpty {
                textContent = textContent + ", EP\(episodeNum)"
            } else if let episodeNum = self.episodeNumber, episodeNum != 0 {
                textContent = textContent + "EP\(episodeNum)"
            }
            if let episodeTitle = self.episodeName, !episodeTitle.isEmpty, !textContent.isEmpty {
                textContent = textContent +  " | \(episodeTitle)"
            } else if let episodeTitle = self.episodeName, !episodeTitle.isEmpty {
                textContent = textContent + "\(episodeTitle)"
            }
            return textContent
        case .match:
            switch teamTemplate {
            case .noTeams:
                return self.programDescription ?? ""
            default:
                return self.title ?? ""
            }
        case .movie:
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
        default:
            return self.programDescription ?? ""
        }
    }
    
    public var shortDescripitionEpg: String {
        switch contentType {
        case .episode:
            var textContent = ""
            if let seasonNum = self.seasonNumber, seasonNum != 0 {
                textContent = "S\(seasonNum)"
            }
            if let episodeNum = self.episodeNumber, episodeNum != 0, !textContent.isEmpty {
                textContent = textContent + ", EP\(episodeNum)"
            } else if let episodeNum = self.episodeNumber, episodeNum != 0 {
                textContent = textContent + "EP\(episodeNum)"
            }
            if let episodeTitle = self.episodeName, !episodeTitle.isEmpty, !textContent.isEmpty {
                textContent = textContent + " | \(episodeTitle)"
            } else if let episodeTitle = self.episodeName, !episodeTitle.isEmpty {
                textContent = textContent + "\(episodeTitle)"
            }
            return textContent
        case .match:
            switch teamTemplate {
            case .noTeams:
                return self.programDescription ?? ""
            default:
                return self.title ?? ""
            }
        case .movie:
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
        default:
            return self.programDescription ?? ""
        }
    }
    
    public var programTitle: String {
        switch contentType {
        case .match:
            switch teamTemplate {
            case .awayAtHome:
                return "\(self.awayTeam?.teamName ?? "") at \(self.homeTeam?.teamName ?? "")"
            case .homeVsAway:
                return "\(self.homeTeam?.teamName ?? "") vs \(self.awayTeam?.teamName ?? "")"
            default:
                return self.title ?? ""
            }
        case .movie:
            return self.title ?? ""
        case .episode:
            return self.title ?? ""
        default:
            return self.title ?? ""
        }
    }
    
    public var percentageOfAiringElapsed:Double {
        if let startDate = self.startDate, let endDate = self.endDate {
            let programLength = endDate.timeIntervalSince(startDate)
            let currentWatchedLength = Date().timeIntervalSince(startDate)
            let progress = currentWatchedLength/programLength
            return progress
        }
        return 0.0
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tmsId = try values.decodeIfPresent(String.self, forKey: .tmsId)
        airingId = try values.decodeIfPresent(String.self, forKey: .airingId)
        sourceType = try values.decodeIfPresent(SourceType.self, forKey: .sourceType) ?? .unknown
        title = try values.decodeIfPresent(String.self, forKey: .title)
        episodeName = try values.decodeIfPresent(String.self, forKey: .episodeName)
        seasonNumber = try values.decodeIfPresent(Int.self, forKey: .seasonNumber)
        episodeNumber = try values.decodeIfPresent(Int.self, forKey: .episodeNumber)
        releaseYear = try values.decodeIfPresent(Int.self, forKey: .releaseYear)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        programDescription = try values.decodeIfPresent(String.self, forKey: .programDescription)
        letterImageUrl = try values.decodeIfPresent(String.self, forKey: .letterImageUrl)
        startDateTime = try values.decodeIfPresent(String.self, forKey: .startDateTime)
        endDateTime = try values.decodeIfPresent(String.self, forKey: .endDateTime)
//        startDate = FuboDateStyler.getDate(forString: startDateTime)
//        endDate = FuboDateStyler.getDate(forString: endDateTime)
        lookbackStartDateTime = try values.decodeIfPresent(String.self, forKey: .lookbackStartDateTime)
        lookbackEndDateTime = try values.decodeIfPresent(String.self, forKey: .lookbackEndDateTime)
        networkID = try values.decodeIfPresent(Int.self, forKey: .networkID)
        networkName = try values.decodeIfPresent(String.self, forKey: .networkName)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        networkLogoThumbnailURL = try values.decodeIfPresent(String.self, forKey: .networkLogoThumbnailURL)
        networkLogoOnWhiteURL = try values.decodeIfPresent(String.self, forKey: .networkLogoOnWhiteURL)
        networkLogoOnDarkURL = try values.decodeIfPresent(String.self, forKey: .networkLogoOnDarkURL)
        streamURL = try values.decodeIfPresent(String.self, forKey: .streamURL)
        allowDVR = try values.decodeIfPresent(Bool.self, forKey: .allowDVR)
        displayName = try values.decodeIfPresent(String.self, forKey: .displayName)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        isNew = try values.decodeIfPresent(Bool.self, forKey: .isNew)
        homeTeam = try values.decodeIfPresent(Team.self, forKey: .homeTeam)
        awayTeam = try values.decodeIfPresent(Team.self, forKey: .awayTeam)
        teamTemplate = try values.decodeIfPresent(TeamTemplate.self, forKey: .teamTemplate) ?? .noTeams
        seriesID = try values.decodeIfPresent(Int.self, forKey: .seriesID)
        seriesName = try values.decodeIfPresent(String.self, forKey: .seriesName)
        contentType = try values.decodeIfPresent(ContentType.self, forKey: .contentType) ?? .other
        playbackType = try values.decodeIfPresent(String.self, forKey: .playbackType)
        networkOwner = try values.decodeIfPresent(String.self, forKey: .networkOwner)
        fullStartover = try values.decodeIfPresent(Bool.self, forKey: .fullStartover)
    }
    
    override public init() {
        super.init()
    }
    
    init(search: SearchAiring) {
        airingId = search.airingId
        sourceType = search.sourceType ?? .unknown
        startDate = search.accessRights?.airingStartTime
        endDate = search.accessRights?.airingEndTime
        duration = search.duration
    }
}

