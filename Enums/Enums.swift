//
//  Enums.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import Foundation

enum GameType : String, CaseIterable {
    case walk = "Walking"
    case run = "Running"
    case archery = "Archery"
    case badminton = "Badminton"
    case baseball = "Baseball"
    case basketball = "Basketball"
    case bowling = "Bowling"
    case boxing = "Boxing"
    case climbing = "Climbing"
    case cricket = "Cricket"
    case curling = "Curling"
    case dance = "Dancing"
    case fencing = "Fencing"
    case fishing = "Fishing"
    case golf = "Golf"
    case gymnastics = "Gymnastics"
    case hiking = "Hiking"
    case hockey = "Hockey"
    case hunting = "Hunting"
    case kickboxing = "Kickboxing"
    case lacrosse = "Lacrosse"
    case pickleball = "Pickleball"
    case pilates = "Pilates"
    case racquetball  = "Racquetball"
    case rugby = "Rugby"
    case skating = "Skating"
    case snowboarding = "Snowboarding"
    case soccer = "Soccer"
    case squash = "Squash"
    case surfing = "Surfing"
    case tennis = "Tennis"
    case volleyball = "Volleyball"
    case waterpolo  = "Water Polo"
    case wrestling = "Wrestling"
    case yoga = "Yoga"
    case american_football = "Football"
    case skiing_downhill = "Skiing"
    case martial_arts = "Martial Arts"
    case outdoor_cycle = "Cycling"
    case pool_swim = "Swimming"
    case strengthtraining_traditional  = "Weight lifting"
    case none = "NONE"
    
    var icon_string : String
    {
        let special_cases : [GameType : String] = [.strengthtraining_traditional : "figure.strengthtraining.traditional",
                                                   .pool_swim : "figure.pool.swim",
                                                   .outdoor_cycle : "figure.outdoor.cycle",
                                                   .martial_arts : "figure.martial.arts",
                                                   .skiing_downhill : "figure.skiing.downhill",
                                                   .american_football : "figure.american.football",
                                                   .waterpolo : "figure.waterpolo",
                                                   .walk : "figure.walk",
                                                   .run : "figure.run",
                                                   .dance : "figure.dance",
                                                   .none : "pencil.line"]
        if special_cases[self] != nil {
            return special_cases[self]!
        }
        return "figure."+self.rawValue.lowercased()
    }
}
