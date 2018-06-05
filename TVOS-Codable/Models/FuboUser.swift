//
//  FuboUser.swift
//  TVOS-Codable
//
//  Created by Raoul Koopman on 6/5/18.
//  Copyright © 2018 fuboTV. All rights reserved.
//

import Foundation

//MARK: - FuboBillingInfo
class FuboBillingInfo: Codable {
    
    private(set) var cardType: String?
    private(set) var lastFour: String?
    private(set) var zip: String?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case cardType = "card_type"
        case lastFour = "last_four"
        case zip
    }
}


//MARK: - FuboAddOn
class FuboAddOn: Codable {
    
    private(set) var name: String?
    private(set) var addOnCode: String?
    private(set) var unitAmountInCents: String?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        case name
        case addOnCode = "add_on_code"
        case unitAmountInCents = "unit_amount_in_cents"
    }
}


//MARK: - FuboUserPlan
class FuboUserPlan: Codable {
    
    private(set) var name: String?
    private(set) var planCode: String?
    private(set) var planIntervalLength: String?
    private(set) var planIntervalUnit: String?
    private(set) var unitAmountInCents: String?
    private(set) var addOns: [FuboAddOn]?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        case name
        case planCode = "plan_code"
        case planIntervalLength = "plan_interval_length"
        case planIntervalUnit = "plan_interval_unit"
        case unitAmountInCents = "unit_amount_in_cents"
        case addOns = "add_ons"
    }
}


//MARK: - FuboUserIab
class FuboUserIab: Codable {
    
    private(set) var correlationId: String?
    private(set) var displayName: String?
    private(set) var provider: String?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case correlationId = "correlation_id"
        case displayName = "display_name"
        case provider
    }
}


//MARK: - FuboUserSubscription
class FuboUserSubscription: Codable {
    
    private(set) var uuid: String?
    private(set) var state: String?
    private(set) var quantity: String?
    private(set) var totalAmountInCents: String?
    private(set) var activatedAt: String?
    private(set) var currentPeriodStartedAt: String?
    private(set) var currentPeriodEndsAt: String?
    private(set) var trialStartedAt: String?
    private(set) var trialEndsAt: String?
    private(set) var plan: FuboUserPlan?
    private(set) var isPro: Bool?
    private(set) var currency: String?
    private(set) var hash: String?
    private(set) var iab: FuboUserIab?
    private(set) var platform: String?
    private(set) var unitAmountInCents: String?
    private(set) var collectionMethod: String?
    private(set) var pendingSubscription: FuboUserPlan?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case uuid
        case state
        case quantity
        case totalAmountInCents = "total_amount_in_cents"
        case activatedAt = "activated_at"
        case currentPeriodStartedAt = "current_period_started_at"
        case currentPeriodEndsAt = "current_period_ends_at"
        case trialStartedAt = "trial_started_at"
        case trialEndsAt = "trial_ends_at"
        case plan
        case isPro
        case currency
        case hash
        case platform
        case unitAmountInCents = "unit_amount_in_cents"
        case collectionMethod = "collection_method"
        case pendingSubscription = "pending_subscription"
    }
}

//MARK: - FuboLastTransaction
class FuboLastTransaction: Codable {
    
    private(set) var amountInCents: String?
    private(set) var date: String?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case amountInCents = "amount_in_cents"
        case date
    }
}


//MARK: - FuboUserRecurly
class FuboUserRecurly: Codable {
    
    private(set) var billingInfo: FuboBillingInfo?
    private(set) var id: String?
    private(set) var subscription: FuboUserSubscription?
    private(set) var planSlug: String?
    private(set) var purchasedPackages: [String]?
    private(set) var subscriptionHash: String?
    private(set) var lastTransaction: FuboLastTransaction?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case billingInfo
        case id
        case subscription
        case planSlug = "plan_slug"
        case purchasedPackages = "purchased_packages"
        case subscriptionHash
        case lastTransaction
    }
}


//MARK: - FuboUserProfile
class FuboUserProfile: Codable {
    
    var id: String?
    var profileName: String?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case id
        case profileName
    }
}


//MARK: - FuboUser
class FuboUser: Codable {
    
    private(set) var id: String?
    private(set) var email: String?
    private(set) var firstName: String?
    private(set) var lastName: String?
    private(set) var language: String?
    private(set) var homePostalCode: String?
    private(set) var countryCode: String?
    private(set) var homePostalLastModified: Double?
    private(set) var recurly: FuboUserRecurly?
    private(set) var password: String?
    private(set) var homePostalVerified: Bool?
    private(set) var profiles: [FuboUserProfile]?
    private(set) var updatedAt: String?
    private(set) var createdAt: String?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        
        case id
        case email
        case firstName = "givenName"
        case lastName = "familyName"
        case language
        case homePostalCode
        case countryCode
        case homePostalLastModified
        case recurly
        case password
        case homePostalVerified
        case profiles
        case updatedAt
        case createdAt
    }
    
    //MARK: • Getters
    var postCodeModificationDate: Date {
        return Date(timeIntervalSince1970: homePostalLastModified ?? Date().timeIntervalSince1970)
    }
}

extension FuboUser {
    
    private static let unknownUser = "Unknown"
    
    var fullName: String {
        let fullName = "\(firstName ?? "") \(lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
        return fullName.isEmpty ? FuboUser.unknownUser : fullName
    }
}


//MARK: - FuboUserResponse
class FuboUserResponse: Codable {
    
    private(set) var fuboUser: FuboUser?
    
    //MARK: • Keys
    enum CodingKeys: String, CodingKey {
        case fuboUser = "data"
    }
}

