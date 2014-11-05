//
//  Word.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 20.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import Foundation
import CoreData

class Word: NSManagedObject {

    @NSManaged var category: NSNumber
    @NSManaged var de: String
    @NSManaged var en: String
    @NSManaged var es: String
    @NSManaged var exampleSentence: String?
    @NSManaged var fr: String
    @NSManaged var it: String
    @NSManaged var lesson: NSNumber
    @NSManaged var level: NSNumber
    @NSManaged var wordID: NSNumber
    @NSManaged var wordType: NSNumber


    class func getWords(level : Int, lesson : Int , nativeLanguage : String, foreignLanguage : String) -> NSMutableArray
    {
        let managedObjectContext : NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var error : NSError? = nil
        var fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Word")
        let tempLevel = 1
        let tempLesson = 1
        fetchRequest.predicate = NSPredicate(format: "level=%i AND lesson=%i", tempLevel,tempLesson)
        fetchRequest.fetchLimit = 30
        var words = managedObjectContext.executeFetchRequest(fetchRequest, error:&error) as [Word]
        
        //wrong words
        fetchRequest = NSFetchRequest(entityName: "Word")
        var words2 = managedObjectContext.executeFetchRequest(fetchRequest, error:&error) as [Word]
        let length = words2.count
        let numberOfRandomSamples : Int = 90
        var wrongWords : NSMutableArray = []
        for var sampleIndex : Int = 0; sampleIndex < numberOfRandomSamples; ++sampleIndex
        {
            var randomIndex = Int(arc4random_uniform(UInt32(length)))
            wrongWords.addObject(words2[randomIndex])
        }
        
        
        var wordModel : NSMutableArray = []
        
        
        for var i = 0; i < words.count; ++i
        {
            var innerWordsModel : NSMutableArray = []
            innerWordsModel.addObject(words[i])
            for var j = 0; j < 3; ++j{
                innerWordsModel.addObject(wrongWords[(j+i*3)])
            }
            wordModel.addObject(innerWordsModel)
        }
        
        return wordModel;
    }
    
    class func getWordTranslation(language : String, wordID : Int) -> String
    {
        let managedObjectContext : NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var error : NSError? = nil
        var fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Word")
        fetchRequest.predicate = NSPredicate(format: "wordID=%i",wordID)
        var words = managedObjectContext.executeFetchRequest(fetchRequest, error:&error) as [Word]
        var word : Word = words[0]
        if language == "DE"
        {
            return word.de
        }
        else if language == "EN"
        {
            return word.en
        }
        else
        {
            return word.de
        }
    
    }
    
    class var mappingDictionary: NSDictionary
    {
        get {
            return [
                "id": "wordID",
                "DE": "de",
                "FR" : "fr",
                "EN" : "en",
                "IT" : "it",
                "ES" : "es",
                "example": "exampleSentence",
                "lesson": "lesson",
                "level" : "level",
                "type" : "wordType",
                "category" : "category"
            ]
        }
    }
    
    class func wordEntityMapper() -> RKEntityMapping
    {
        var wordMapper: RKEntityMapping = RKEntityMapping(forEntityForName: "Word", inManagedObjectStore: LGCoreDataManager.sharedInstance().managedObjectStore)
        wordMapper.addAttributeMappingsFromDictionary(self.mappingDictionary)
        wordMapper.identificationAttributes = ["wordID"]
        return wordMapper
    }
    
    class var responseDescriptor: RKResponseDescriptor
    {
        var wordMapper = Word.wordEntityMapper()
        var wordResponseDescriptor = RKResponseDescriptor(mapping: wordEntityMapper(),
            method: .Any, pathPattern: nil, keyPath: "response", statusCodes:nil)
        return wordResponseDescriptor
    }

}
