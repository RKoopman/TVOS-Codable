//
//  PromotedAction.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

enum PromotedLinkAction: String, Codable {
    case sportsCategory = "sports"
}

public struct PromotedLink:Codable {
    var action: PromotedLinkAction?
    var sport: Sport?
}

open class PromotedLinkParser {
    
    // URL format is [SOURCE_TYPE]/[COMMAND]/[ID]
    static func urlToPromotedLinkAction(_ url: String) -> PromotedLink? {
        
        var pathComponents = url.split(separator: "/")
        print("promoted link params from link \(pathComponents)")
        
        if pathComponents.count == 2, pathComponents[0] == PromotedLinkAction.sportsCategory.rawValue {
            var returnedPromotedLink = PromotedLink()
            let sportString = String(pathComponents[1])
            
            if let sportId = Int(sportString) {
                let sport = Sport(sportID: sportId, sportName: nil)
                sport.sportID = sportId
                returnedPromotedLink.sport = sport
                return returnedPromotedLink
            }
            return nil
        }
        return nil
    }
}
