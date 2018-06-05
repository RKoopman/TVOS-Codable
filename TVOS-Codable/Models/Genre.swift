//
//  Genre.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

public class Genre: NSObject, Codable {
    public var genreID: Int?
    public var genreLogoURL: String?
    public var genreName: String?
    
    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case genreLogoURL = "genreLogoUrl"
        case genreName = "genreName"
    }
    
    init(genreID: Int?, genreLogoURL: String?, genreName: String?) {
        self.genreID = genreID
        self.genreLogoURL = genreLogoURL
        self.genreName = genreName
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genreID = try values.decodeIfPresent(Int.self, forKey: .genreID)
        genreLogoURL = try values.decodeIfPresent(String.self, forKey: .genreLogoURL)
        genreName = try values.decodeIfPresent(String.self, forKey: .genreName)
    }
}

extension Genre {
    convenience init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Genre.self, from: data) else { return nil }
        self.init(genreID: me.genreID, genreLogoURL: me.genreLogoURL, genreName: me.genreName)
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
