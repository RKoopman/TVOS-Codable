//
//  PromotedMatch.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

open class PromotedMatch: Codable, Recordable {
    public let tmsid, title, customLinkURL, contentType: String?
    public let sportType, thumbnailURL: String?
    public let letterImageURL, carouselImageURL: String?
    public var sourceType: SourceType = .unknown
    public let homeTeam, awayTeam: Team?
    let teamTemplate: TeamTemplate?
    let airings: [Airing]?
    let buttonText, matchTitle, matchDescription: String?
    let sport: Sport?
    let league: League?
    var promotedLinkAction: PromotedLink? = nil
    
    enum CodingKeys: String, CodingKey {
        case tmsid, title
        case customLinkURL = "customLinkUrl"
        case contentType, sportType
        case sourceType = "sourceType"
        case thumbnailURL = "thumbnailUrl"
        case letterImageURL = "letterImageUrl"
        case carouselImageURL = "carouselImageUrl"
        case homeTeam, awayTeam, teamTemplate, airings, buttonText, matchTitle, matchDescription, sport, league
    }
    
    init(tmsid: String?, title: String?, customLinkURL: String?, contentType: String?, sourceType: SourceType, sportType: String?, thumbnailURL: String?, letterImageURL: String?, carouselImageURL: String?, homeTeam: Team?, awayTeam: Team?, teamTemplate: TeamTemplate?, airings: [Airing]?, buttonText: String?, matchTitle: String?, matchDescription: String?, sport: Sport?, league: League?, promotedAction: PromotedLink?) {
        self.tmsid = tmsid
        self.title = title
        self.customLinkURL = customLinkURL
        self.contentType = contentType
        self.sourceType = sourceType
        self.sportType = sportType
        self.thumbnailURL = thumbnailURL
        self.letterImageURL = letterImageURL
        self.carouselImageURL = carouselImageURL
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.teamTemplate = teamTemplate
        self.airings = airings
        self.buttonText = buttonText
        self.matchTitle = matchTitle
        self.matchDescription = matchDescription
        self.sport = sport
        self.league = league
        self.promotedLinkAction = promotedAction
    }
    
    var isRecordable: Bool {
        guard let airing = airings?.first else {
            return false
        }
        
        return airing.allowDVR ?? false
    }
    
    public var isLive: Bool {
        return self.airings?.first?.isLive ?? false
    }
    
    public var isLookback: Bool {
        return self.airings?.first?.isLookback ?? false
    }
    
    public var airingId:String? {
        return airings?.first?.airingId
    }
}

extension PromotedMatch:StationPlayable {
    public var stationId:String? {
        guard let networkId = airings?.first?.networkID else {
            return nil
        }
        return String(networkId)
    }
}


// MARK: Alamofire response handlers -

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    func responsePromotedMatch(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<PromotedMatch>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

// MARK: Convenience initializers

extension PromotedMatch {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(PromotedMatch.self, from: data)
        self.init(tmsid: me.tmsid, title: me.title, customLinkURL: me.customLinkURL, contentType: me.contentType, sourceType: me.sourceType, sportType: me.sportType, thumbnailURL: me.thumbnailURL, letterImageURL: me.letterImageURL, carouselImageURL: me.carouselImageURL, homeTeam: me.homeTeam, awayTeam: me.awayTeam, teamTemplate: me.teamTemplate, airings: me.airings, buttonText: me.buttonText, matchTitle: me.matchTitle, matchDescription: me.matchDescription, sport: me.sport, league: me.league, promotedAction: me.promotedLinkAction)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
