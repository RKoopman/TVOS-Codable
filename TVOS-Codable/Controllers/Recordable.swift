//
//  Recordable.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

public protocol Recordable {
    var airingId:String? {get}
    var isLive:Bool {get}
    var isLookback:Bool {get}
    var sourceType:SourceType {get}
}
