//
//  PromotedTv.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation
import Alamofire

open class PromotedTv: Codable {
    let tmsID, customLinkURL, title: String?
    let promotedDescription, thumbnailURL, letterImageURL: String?
    let carouselImageURL: String?
    public var sourceType: SourceType = .unknown
    public var contentType: ContentType? = .other
    let airings: [Airing]?
    let buttonText: String?
    let episodeNumber, seasonNumber, seriesID, releaseYear: Int?
    let seriesName, episodeName, rating: String?
    
    enum CodingKeys: String, CodingKey {
        case tmsID = "tmsId"
        case customLinkURL = "customLinkUrl"
        case title, contentType
        case promotedDescription = "description"
        case sourceType = "sourceType"
        case thumbnailURL = "thumbnailUrl"
        case letterImageURL = "letterImageUrl"
        case carouselImageURL = "carouselImageUrl"
        case airings, buttonText, episodeNumber, seasonNumber
        case seriesID = "seriesId"
        case seriesName, episodeName, rating, releaseYear
    }
    
    init(tmsID: String?, customLinkURL: String?, title: String?, contentType: ContentType?, sourceType: SourceType, description: String?, thumbnailURL: String?, letterImageURL: String?, carouselImageURL: String?, airings: [Airing]?, buttonText: String?, episodeNumber: Int?, seasonNumber: Int?, seriesID: Int?, seriesName: String?, episodeName: String?, rating: String?, releaseYear: Int?) {
        self.tmsID = tmsID
        self.customLinkURL = customLinkURL
        self.title = title
        self.contentType = contentType
        self.sourceType = sourceType
        self.promotedDescription = description
        self.thumbnailURL = thumbnailURL
        self.letterImageURL = letterImageURL
        self.carouselImageURL = carouselImageURL
        self.airings = airings
        self.buttonText = buttonText
        self.episodeNumber = episodeNumber
        self.seasonNumber = seasonNumber
        self.seriesID = seriesID
        self.seriesName = seriesName
        self.episodeName = episodeName
        self.rating = rating
        self.releaseYear = releaseYear
    }
    
    var isRecordable: Bool {
        guard let airing = airings?.first else {
            return false
        }
        return airing.allowDVR ?? false
    }
    
    var subtitleMovie: String {
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
    
    var subtitleEpisode: String {
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
    }
}

extension PromotedTv:FTRecordable {
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

extension PromotedTv:FTStationPlayable {
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
    func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responsePromotedTv(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<PromotedTv>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

// MARK: Convenience initializers

extension PromotedTv {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(PromotedTv.self, from: data)
        self.init(tmsID: me.tmsID, customLinkURL: me.customLinkURL, title: me.title, contentType: me.contentType, sourceType: me.sourceType, description: me.promotedDescription, thumbnailURL: me.thumbnailURL, letterImageURL: me.letterImageURL, carouselImageURL: me.carouselImageURL, airings: me.airings, buttonText: me.buttonText, episodeNumber: me.episodeNumber, seasonNumber: me.seasonNumber, seriesID: me.seriesID, seriesName: me.seriesName, episodeName: me.episodeName, rating: me.rating, releaseYear: me.releaseYear)
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
