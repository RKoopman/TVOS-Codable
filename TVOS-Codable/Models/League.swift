//
//  League.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

class League: Codable {
    
    var leagueID: Int?
    var leagueName: String?
    
    enum CodingKeys: String, CodingKey {
        case leagueID = "leagueId"
        case leagueName = "leagueName"
    }
    
    init(leagueID: Int?, leagueName: String?) {
        self.leagueID = leagueID
        self.leagueName = leagueName
    }
    
    required init(from decoder: Decoder) throws {
        
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        leagueName = try container.decodeIfPresent(String.self, forKey: .leagueName)
        
        do {
            leagueID = try container.decodeIfPresent(Int.self, forKey: .leagueID)
        } catch {
            if let id = try container.decodeIfPresent(String.self, forKey: .leagueID) {
                leagueID = Int(id)
            }
        }
    }
}

extension League {
    
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(League.self, from: data)
        self.init(leagueID: me.leagueID, leagueName: me.leagueName)
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
