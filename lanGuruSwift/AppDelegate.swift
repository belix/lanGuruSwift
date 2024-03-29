//
//  AppDelegate.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 20.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        //initialize facebookLogin
        FBLoginView.self()
        
        //initialize core data manager
        LGCoreDataManager.sharedInstance().setupStoreManager()
        
        UIApplication.sharedApplication().registerForRemoteNotifications()
        let settings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        //load vocabulary once
        if self.vabularyAlreadDownloaded() == false
        {
            let vocabularyClient : LGVocabularyClient = LGVocabularyClient()
            vocabularyClient.downloadVocabularyWithCompletion(nil)
        }
        
        //appearance
        UITabBar.appearance().barTintColor = UIColor(red: 44/255.0, green: 64/255.0, blue: 84/255.0, alpha: 1)
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 44/255.0, green: 64/255.0, blue: 84/255.0, alpha: 1)
        
        UITabBar.appearance().tintColor = UIColor(red: 0, green: 0.816, blue: 0.68, alpha: 1)
        
        return true
    }
    
    func vabularyAlreadDownloaded() -> Bool {
        var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if (userDefaults.objectForKey("vocabularyDownloaded") != nil) {
            return true
        }
        
        return false
    }
    
    
    // implemented in your application delegate
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!)
    {
        println("Got token data! \(deviceToken)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError!)
    {
        println("Couldn't register: \(error)")
    }
    
    func logWords()
    {
        //fetch families
        NSLog(" ======== Fetch ======== ")
        
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Word")
        
        var result = CoreDataManager.sharedInstance.managedObjectContext.executeFetchRequest(fReq, error:&error)
        for resultItem in result! {
            var wordItem = resultItem as Word
            NSLog("Fetched word for \(wordItem.de) ")
        }
        
    }
    
    
    func logUser()
    {
        //fetch families
        NSLog(" ======== Fetch ======== ")
        
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "User")
    
        var result = RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext.executeFetchRequest(fReq, error:&error)
        for resultItem in result! {
            var userItem = resultItem as User
            NSLog("Fetched user for \(userItem.username) ")
        }
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }


}

