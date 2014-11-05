//
//  Match.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 28.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class Match: NSObject {
   
    var identity : Int = 0
    var opponent1 : String = ""
    var opponent2 : String = ""
    var opponent1UserID : Int = 0
    var opponent2UserID : Int = 0
    var nativelang1 : String = ""
    var nativelang2 : String = ""
    var ranking1 : Int = 0
    var ranking2 : Int = 0
    var status : Int = 0
    var content = []
    
    var result1 : String = ""
    var result2 : String = ""
    
    var level : Int = 0
    var score1 : Int = 0
    var score2 : Int = 0
    var opponentScore : Int = 0
    
    var rankdiff1 : Int = 0
    var rankdiff2 : Int = 0
    
    var opponentCoverPic : String = ""
    var opponentProfilePic : String = ""
    
    class var mappingDictionary: NSDictionary
    {
        get {
            return [
            "id"            : "identity",
            "username1"     : "opponent1",
            "username2"     : "opponent2",
            "user1"         : "opponent1UserID",
            "user2"         : "opponent2UserID",                
            "nativelang1"   : "nativelang1",
            "nativelang2"   : "nativelang2",
            "ranking1"      : "ranking1",
            "ranking2"      : "ranking2",
            "active"        : "status",
            "words"         : "content",
            "result1"       : "result1",
            "result2"       : "result2",
            "level"         : "level",
            "score1"        : "score1",
            "score2"        : "score2",
            "rankdiff1"     : "rankdiff1",
            "rankdiff2"     : "rankdiff2",
            "coverpic"      : "opponentCoverPic",
            "profilepic"    : "opponentProfilePic",
            "opponentScore" : "opponentScore"
            ]
        }
    }
    
    class func matchEntityMapper() -> RKObjectMapping
    {
        var matchMapper : RKObjectMapping = RKObjectMapping(forClass: self)
        matchMapper.addAttributeMappingsFromDictionary(self.mappingDictionary)
        
        return matchMapper
    }
    
    class var responseDescriptor: RKResponseDescriptor
    {
        var matchResponseDescriptor = RKResponseDescriptor(mapping: matchEntityMapper(),
            method: RKRequestMethod.Any , pathPattern: nil, keyPath: "match", statusCodes:nil)
        
        return matchResponseDescriptor
    }
    
    class var responseDescriptorForActiveMatches: RKResponseDescriptor
    {
        var matchResponseDescriptor = RKResponseDescriptor(mapping: matchEntityMapper(),
            method: RKRequestMethod.Any , pathPattern: nil, keyPath: "matches", statusCodes:nil)
        
        return matchResponseDescriptor
    }
    
}
