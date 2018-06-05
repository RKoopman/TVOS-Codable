//
//  Sport.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

class Sport: Codable {
    var sportID: Int?
    var sportName: String?
    
    enum CodingKeys: String, CodingKey {
        case sportID = "sportId"
        case sportName
    }
    
    init(sportID: Int?, sportName: String?) {
        self.sportID = sportID
        self.sportName = sportName
    }
}

extension Sport {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Sport.self, from: data)
        self.init(sportID: me.sportID, sportName: me.sportName)
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

