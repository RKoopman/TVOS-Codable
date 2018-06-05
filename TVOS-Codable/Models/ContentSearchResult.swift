//
//  ContentSearchResult.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

//MARK: - SearchResultType
enum SearchResultType: String {
    case series
    case match
    case movie
    case unknown
}


//MARK: - SearchMatchMetadata
class SearchMatchMetadata: Codable {
    
    private(set) var title: String?
    private(set) var teamTemplate: TeamTemplate?
    private(set) var homeTeam: Team?
    private(set) var awayTeam: Team?
    private(set) var leagues: [League]?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case title
        case teamTemplate
        case homeTeam
        case awayTeam
        case leagues
    }
}


//MARK: - SearchMovieMetadata
class SearchMovieMetadata: Codable {
    
    private(set) var releaseYear: Int?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        case releaseYear
    }
}


//MARK: - SearchProgram
class SearchProgram: Codable {
    
    private(set) var tmsId: String?
    private(set) var title: String?
    private(set) var shortDescription: String?
    private(set) var longDescription: String?
    private(set) var language: String?
    private(set) var letterImage: String?
    private(set) var heroImage: String?
    private(set) var rating: String?
    private(set) var programType: String?
    private(set) var matchMetadata: SearchMatchMetadata?
    private(set) var movieMetadata: SearchMovieMetadata?
    
    //MARK: • Getters
    var type: SearchResultType {
        return SearchResultType(rawValue: programType ?? "") ?? .unknown
    }
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case tmsId
        case title
        case shortDescription
        case longDescription
        case language
        case letterImage
        case heroImage
        case rating
        case programType = "type"
        case matchMetadata
        case movieMetadata
    }
}


//MARK: - SearchProvideInfo
class SearchProviderInfo: Codable {
    
    private(set) var stationId: Int?
    private(set) var stationName: String?
    private(set) var stationLogoThumbnailUrl: String?
    private(set) var stationLogoOnWhiteUrl: String?
    private(set) var stationLogoOnDarkUrl: String?
    private(set) var callSign: String?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case stationId
        case stationName
        case stationLogoThumbnailUrl
        case stationLogoOnWhiteUrl
        case stationLogoOnDarkUrl
        case callSign
    }
}


//MARK: - SearchAccessRights
class SearchAccessRights: Codable {
    
    private(set) var airingStartTime: Date?
    private(set) var airingEndTime: Date?
    private(set) var startOverStartTime: Date?
    private(set) var startOverEndTime: Date?
    private(set) var allowDVR: Bool?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case airingStartTime
        case airingEndTime
        case startOverStartTime
        case startOverEndTime
        case allowDVR
    }
}


//MARK: - SearchAiring
class SearchAiring: Codable {
    
    private(set) var airingId: String?
    private(set) var sourceType: SourceType?
    private(set) var duration: Int?
    private(set) var streamUrl: String?
    private(set) var program: SearchProgram?
    private(set) var providerInfo: SearchProviderInfo?
    private(set) var accessRights: SearchAccessRights?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        case airingId
        case sourceType
        case duration
        case streamUrl
        case program
        case providerInfo
        case accessRights
    }
    
    public var isLive:Bool {
        guard let start = self.accessRights?.airingStartTime, let end = self.accessRights?.airingEndTime else {
            return false
        }
        
        let current = Date()
        return (start <= current && end > current)
    }
}


//MARK: - SearchSeries
class SearchSeries: Codable {
    
    private(set) var id: Int?
    private(set) var name: String?
    private(set) var shortDescription: String?
    private(set) var longDescription: String?
    private(set) var letterImageUrl: String?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case shortDescription
        case longDescription
        case letterImageUrl
    }
}


//MARK: - SearchResult
enum SearchResult: Codable {
    
    case series(SearchSeries)
    case airing(SearchAiring)
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        case series
        case airing
    }
    
    //MARK: • Getters
    var type: SearchResultType {
        switch self {
        case .series:
            return .series
        case .airing(let value):
            return value.program?.type ?? .unknown
        }
    }
    
    var cellModel: CellInfoModel {
        switch self {
        case .series(let series):
            return CellInfoModel(with: series)
        case .airing(let airing):
            return CellInfoModel(with: airing)
        }
    }
    
    
    
    //MARK: • Decodable
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let series = try container.decode(SearchSeries.self, forKey: .series)
            self = .series(series)
        } catch {
            let airing = try container.decode(SearchAiring.self, forKey: .airing)
            self = .airing(airing)
        }
    }
    
    //MARK: • Encodable
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .series(let value):
            try container.encode(value, forKey: .series)
        case .airing(let value):
            try container.encode(value, forKey: .airing)
        }
    }
}


//MARK: - ContentSearchResult
public class ContentSearchResult: Codable {
    
    private(set) var results: [SearchResult] = []
    private(set) var matchesPosition: [Int]?
    private(set) var moviesPosition: [Int]?
    private(set) var seriesPosition: [Int]?
    
    //MARK: • Keys
    private enum CodingKeys: String, CodingKey {
        
        case results
        case matchesPosition = "matches"
        case moviesPosition = "movies"
        case seriesPosition = "series"
    }
    
    //MARK: • Getters
    var series: [SearchResult] {
        return results.filter{ $0.type == .series }
    }
    
    var matches: [SearchResult] {
        return results.filter{ $0.type == .match }
    }
    
    var movies: [SearchResult] {
        return results.filter{ $0.type == .movie }
    }
    
    //MARK: • Filter
    func filterCorruptedResults() {
        results = results.filter({
            switch $0 {
            case .airing(let airing):
                return airing.airingId != nil && (airing.streamUrl != nil || airing.providerInfo?.stationId != nil)
            case .series(let series):
                return series.id != nil
            }
        })
    }
}
