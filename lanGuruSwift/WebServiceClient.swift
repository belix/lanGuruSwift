//
//  WebServiceClient.swift
//  SwiftRestkit
//
//  Created by Bhambhwani, Jaikumar (US - Mumbai) on 6/27/14.
//  Copyright (c) 2014 Jaikumar. All rights reserved.
//

import Foundation

class WebServiceClient {
    
    let baseURL = "http://chaoshennen.de"
    var objectManager : RKObjectManager
    
    // Default initializer
    init() {
        var baseURL: NSURL = NSURL(string : self.baseURL)!
        var client: AFHTTPClient = AFHTTPClient(baseURL: baseURL)
        RKMIMETypeSerialization.registerClass(RKNSJSONSerialization.classForCoder(), forMIMEType: "text/html");

        self.objectManager = RKObjectManager(HTTPClient: client)
        self.objectManager.requestSerializationMIMEType = "application/json"
        self.objectManager.HTTPClient.setDefaultHeader("Content-Type", value: "application/json")
        self.objectManager.setAcceptHeaderWithMIMEType("application/json")
    }
    
    class var sharedInstance: WebServiceClient {
        struct Static {
            static let instance : WebServiceClient = WebServiceClient()
        }
        return Static.instance
    }
    
    // #pragma mark - Web Service Requests
    
    func getProjects(successClosure:((results: NSArray) -> Void)?, failureClosure:((error: NSError) -> Void)?) {

        var operation: RKManagedObjectRequestOperation = operationForPath("/matchmaking/getwords", method: "GET", parameters: nil, descriptors: [Word.responseDescriptor])
        
        operation.setCompletionBlockWithSuccess( {
            (requestOperation: RKObjectRequestOperation?, mappingResult: RKMappingResult?) -> Void in
            
                                                    CoreDataManager.sharedInstance.saveContext()
                                                    var results: NSArray? = mappingResult?.array()?
                                                    println(results)
                                                    if let resultsArray = results {
                                                        if let successClosureBlock = successClosure {
                                                             successClosureBlock(results: resultsArray)
                                                        }
                                                    }
                                                 },
                                                  failure: { (requestOperation: RKObjectRequestOperation?, error: NSError?) -> Void in
                                                    if let errorValue = error {
                                                        if let failureClosureBlock = failureClosure {
                                                            failureClosureBlock(error: errorValue)
                                                        }
                                                    }
                                                })
        
    }
    
    func operationForPath(path: String, method: String, parameters: NSDictionary?, descriptors: [AnyObject]?) -> RKManagedObjectRequestOperation {
        
        var request : NSMutableURLRequest = self.objectManager.HTTPClient!.requestWithMethod(method, path: path, parameters: parameters)
        var operation : RKManagedObjectRequestOperation = RKManagedObjectRequestOperation(request: request, responseDescriptors: descriptors?)
        operation.managedObjectCache = CoreDataManager.sharedInstance.objectStore.managedObjectCache
        operation.managedObjectContext = CoreDataManager.sharedInstance.objectStore.mainQueueManagedObjectContext
        self.objectManager.operationQueue?.addOperation(operation)
        return operation
    }
}

    