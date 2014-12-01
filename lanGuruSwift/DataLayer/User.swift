//
//  User.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 20.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import Foundation
import CoreData

@objc class User: NSManagedObject {

    @NSManaged var coverPicture: String?
    @NSManaged var currentLesson: NSNumber
    @NSManaged var currentLevel: NSNumber
    @NSManaged var facebookID: String
    @NSManaged var foreignLanguage: String
    @NSManaged var lessonProgress: NSNumber
    @NSManaged var levelProgress: NSNumber
    @NSManaged var nativeLanguage: String
    @NSManaged var profilePicture: String?
    @NSManaged var rank: NSNumber
    @NSManaged var ranking: NSNumber
    @NSManaged var userID: NSNumber
    @NSManaged var username: String
    
    
    func getProfilePictureImage() -> UIImage
    {
        if self.profilePicture != nil && self.profilePicture != ""
        {
            if let profilePictureImageData = NSData(base64EncodedString: self.profilePicture!, options: .allZeros)
            {
                return UIImage(data: profilePictureImageData)!
            }
            
        }
        
        return UIImage(named: "facebook_leader_avatar")!
    }
    
    func getCoverPictureImage() -> UIImage
    {
        if self.coverPicture != nil && self.coverPicture != ""
        {
            if let coverPictureImageData = NSData(base64EncodedString: self.coverPicture!, options: .allZeros)
            {
                return UIImage(data: coverPictureImageData)!
            }
            
        }
        
        return UIImage(named: "facebook_leader_avatar")!
    }
    
    class func getLocalUser() -> User
    {
        let manageObjectContext : NSManagedObjectContext = LGCoreDataManager.sharedInstance().managedObjectStore.mainQueueManagedObjectContext
        var error : NSError? = nil
        var fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "User")
        var userID : Int = NSUserDefaults.standardUserDefaults().objectForKey("localUserID")!.integerValue
        fetchRequest.predicate = NSPredicate(format: "userID=%i", userID)
        var users : Array = manageObjectContext.executeFetchRequest(fetchRequest, error: &error)!
        return users.first as User
    }
    
    class var mappingDictionary: NSDictionary {
        get {
            return [
                "id": "userID",
                "fbid": "facebookID",
                "username" : "username",
                "foreignlang" : "foreignLanguage",
                "nativelang" : "nativeLanguage",
                "ranking": "ranking",
                "coverpic" : "coverPicture",
                "profilepic" : "profilePicture"
            ]
        }
    }
    
    class func userEntityMapper() -> RKEntityMapping {
        var userMapper: RKEntityMapping = RKEntityMapping(forEntityForName: "User", inManagedObjectStore: LGCoreDataManager.sharedInstance().managedObjectStore)
        userMapper.addAttributeMappingsFromDictionary(self.mappingDictionary)
        userMapper.identificationAttributes = ["userID"]
        return userMapper
    }
    
    class var responseDescriptor: RKResponseDescriptor {
        
        var teamMemberMapper = User.userEntityMapper()
        var teamMemberResponseDescriptor = RKResponseDescriptor(mapping: userEntityMapper(),
            method: RKRequestMethod.POST , pathPattern: nil, keyPath: "user", statusCodes:nil)
        
        return teamMemberResponseDescriptor
    }
    
    class var responseDescriptorForUserDetails: RKResponseDescriptor {
        
        var teamMemberMapper = User.userEntityMapper()
        var teamMemberResponseDescriptor = RKResponseDescriptor(mapping: userEntityMapper(),
            method: RKRequestMethod.POST , pathPattern: nil, keyPath: "userdetails", statusCodes:nil)
        
        return teamMemberResponseDescriptor
    }

}
