//
//  Team.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

open class Team: Codable {
    var teamName, properName, logoURL: String?
    var teamID: String?
    
    enum CodingKeys: String, CodingKey {
        case teamID = "teamId"
        case teamName, properName
        case logoURL = "logoUrl"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teamName = try values.decodeIfPresent(String.self, forKey: .teamName)
        properName = try values.decodeIfPresent(String.self, forKey: .properName)
        logoURL = try values.decodeIfPresent(String.self, forKey: .logoURL)
        
        do {
            teamID = try values.decodeIfPresent(String.self, forKey: .teamID)
        } catch {
            teamID = "\(try values.decodeIfPresent(Int.self, forKey: .teamID) ?? 0)"
        }
    }
}
