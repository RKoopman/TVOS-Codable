//
//  Program.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

public class Program: Codable {
    
    public var episodeNumber: Int?
    public var episodeTitle: String?
    public var letterImageURL: String?
    public var longDescription: String?
    public var contentType: ContentType = .other
    public var seasonNumber: Int?
    public var shortDescription: String?
    public var thumbnailURL: String?
    public var title: String?
    public var tmsid: String?
    public var year: Int?
    
    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episodeNumber"
        case episodeTitle = "episodeTitle"
        case letterImageURL = "letterImageUrl"
        case longDescription = "longDescription"
        case contentType = "progtype"
        case seasonNumber = "seasonNumber"
        case shortDescription = "shortDescription"
        case thumbnailURL = "thumbnailUrl"
        case title = "title"
        case tmsid = "tmsid"
        case year = "year"
    }
    
    init(episodeNumber: Int?, episodeTitle: String?, letterImageURL: String?, longDescription: String?, contentType: ContentType, seasonNumber: Int?, shortDescription: String?, thumbnailURL: String?, title: String?, tmsid: String?, year: Int?) {
        self.episodeNumber = episodeNumber
        self.episodeTitle = episodeTitle
        self.letterImageURL = letterImageURL
        self.longDescription = longDescription
        self.contentType = contentType
        self.seasonNumber = seasonNumber
        self.shortDescription = shortDescription
        self.thumbnailURL = thumbnailURL
        self.title = title
        self.tmsid = tmsid
        self.year = year
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        episodeNumber = try values.decodeIfPresent(Int.self, forKey: .episodeNumber)
        episodeTitle = try values.decodeIfPresent(String.self, forKey: .episodeTitle)
        letterImageURL = try values.decodeIfPresent(String.self, forKey: .letterImageURL)
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription)
        contentType = try values.decodeIfPresent(ContentType.self, forKey: .contentType) ?? .other
        seasonNumber = try values.decodeIfPresent(Int.self, forKey: .seasonNumber)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        thumbnailURL = try values.decodeIfPresent(String.self, forKey: .thumbnailURL)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        tmsid = try values.decodeIfPresent(String.self, forKey: .tmsid)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
    }
}
