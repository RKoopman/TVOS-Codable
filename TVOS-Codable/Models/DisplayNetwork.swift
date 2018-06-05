//
//  DisplayNetwork.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

open class DisplayNetworks: Codable {
    var displayNetworks: [DisplayNetwork]?
    
    enum CodingKeys: String, CodingKey {
        case displayNetworks = "displayNetworks"
    }
    
    init(displayNetworks: [DisplayNetwork]?) {
        self.displayNetworks = displayNetworks
    }
}

open class DisplayNetwork: Codable {
    var id: Int?
    var name, description, logoOnDarkURL, logoOnWhiteURL: String?
    var backgroundImageURL: String?
    var movies, series, sports, comedy: Bool?
    var documentaries, afterHours: Bool?
    var stations: [Station]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case logoOnDarkURL = "logoOnDarkUrl"
        case logoOnWhiteURL = "logoOnWhiteUrl"
        case backgroundImageURL = "backgroundImageUrl"
        case movies, series, sports, comedy, documentaries, afterHours, stations
    }
    
    init(id: Int?, name: String?, description: String?, logoOnDarkURL: String?, logoOnWhiteURL: String?, backgroundImageURL: String?, movies: Bool?, series: Bool?, sports: Bool?, comedy: Bool?, documentaries: Bool?, afterHours: Bool?, stations: [Station]?) {
        self.id = id
        self.name = name
        self.description = description
        self.logoOnDarkURL = logoOnDarkURL
        self.logoOnWhiteURL = logoOnWhiteURL
        self.backgroundImageURL = backgroundImageURL
        self.movies = movies
        self.series = series
        self.sports = sports
        self.comedy = comedy
        self.documentaries = documentaries
        self.afterHours = afterHours
        self.stations = stations
    }
}

// MARK: Convenience initializers

extension DisplayNetworks {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(DisplayNetworks.self, from: data)
        self.init(displayNetworks: me.displayNetworks)
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

extension DisplayNetwork {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(DisplayNetwork.self, from: data)
        self.init(id: me.id, name: me.name, description: me.description, logoOnDarkURL: me.logoOnDarkURL, logoOnWhiteURL: me.logoOnWhiteURL, backgroundImageURL: me.backgroundImageURL, movies: me.movies, series: me.series, sports: me.sports, comedy: me.comedy, documentaries: me.documentaries, afterHours: me.afterHours, stations: me.stations)
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
