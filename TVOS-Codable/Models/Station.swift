//
//  Station.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

public class Station: NSObject, Codable {
    
    public var id : Int?
    public var name : String?
    public var logoOnDarkUrl : String?
    public var logoOnWhiteUrl : String?
    public var allowDVR : Bool?
    public var callSign : String?
    public var displayNetworkId : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logoOnDarkUrl = "logoOnDarkUrl"
        case logoOnWhiteUrl = "logoOnWhiteUrl"
        case allowDVR = "allowDVR"
        case callSign = "callSign"
        case displayNetworkId = "displayNetworkId"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        logoOnDarkUrl = try values.decodeIfPresent(String.self, forKey: .logoOnDarkUrl)
        logoOnWhiteUrl = try values.decodeIfPresent(String.self, forKey: .logoOnWhiteUrl)
        allowDVR = try values.decodeIfPresent(Bool.self, forKey: .allowDVR)
        callSign = try values.decodeIfPresent(String.self, forKey: .callSign)
        displayNetworkId = try values.decodeIfPresent(Int.self, forKey: .displayNetworkId)
    }
}

