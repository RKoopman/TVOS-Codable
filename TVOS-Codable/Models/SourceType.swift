//
//  File.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

public enum SourceType: String, Codable {
    
    case unknown = "unknown"
    case live = "stream"
    case lookback = "lookback"
    case vod = "vod"
    case dvr = "dvr"
    case link = "link"
}
