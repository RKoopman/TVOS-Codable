//
//  Network.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

typealias Networks = [Network]

public class Network: Codable {
    let networkID: Int?
    let networkName: String?
    let slug: String?
    let networkLogoThumbnailURL: String?
    let networkLogoOnWhiteURL: String?
    let networkLogoOnDarkURL: String?
    let streamURL: String?
    let allowDVR: Bool?
    let displayName: String?
    let networkDescription: String?
    let type: String?
    let category: String?
    
    enum CodingKeys: String, CodingKey {
        case networkID = "networkId"
        case networkName = "networkName"
        case slug = "slug"
        case networkLogoThumbnailURL = "networkLogoThumbnailUrl"
        case networkLogoOnWhiteURL = "networkLogoOnWhiteUrl"
        case networkLogoOnDarkURL = "networkLogoOnDarkUrl"
        case streamURL = "streamUrl"
        case allowDVR = "allowDVR"
        case displayName = "displayName"
        case networkDescription = "description"
        case type = "type"
        case category = "category"
    }
    
    init(networkID: Int?, networkName: String?, slug: String?, networkLogoThumbnailURL: String?, networkLogoOnWhiteURL: String?, networkLogoOnDarkURL: String?, streamURL: String?, allowDVR: Bool?, displayName: String?, networkDescription: String?, type: String?, category: String?) {
        self.networkID = networkID
        self.networkName = networkName
        self.slug = slug
        self.networkLogoThumbnailURL = networkLogoThumbnailURL
        self.networkLogoOnWhiteURL = networkLogoOnWhiteURL
        self.networkLogoOnDarkURL = networkLogoOnDarkURL
        self.streamURL = streamURL
        self.allowDVR = allowDVR
        self.displayName = displayName
        self.networkDescription = networkDescription
        self.type = type
        self.category = category
    }
}

// MARK: Convenience initializers

extension Network {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Network.self, from: data)
        self.init(networkID: me.networkID, networkName: me.networkName, slug: me.slug, networkLogoThumbnailURL: me.networkLogoThumbnailURL, networkLogoOnWhiteURL: me.networkLogoOnWhiteURL, networkLogoOnDarkURL: me.networkLogoOnDarkURL, streamURL: me.streamURL, allowDVR: me.allowDVR, displayName: me.displayName, networkDescription: me.networkDescription, type: me.type, category: me.category)
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
