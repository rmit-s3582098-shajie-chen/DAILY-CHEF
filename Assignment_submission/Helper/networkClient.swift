//
//  networkClient.swift
//  Assignment_1
//
//  Created by SJ cheng on 31/1/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit

class networkClient{
    // MARK: GET
    
    func taskForGETMethod(method: String, parameters: [String: AnyObject], completionHandlerForGET: @escaping (_ result: [String: AnyObject]?, _ error: NSError?) -> Void) {
        // Setting the parameters
        var parameters = parameters
        parameters[Base.Food2ForkParameterKeys.APIKey] = Base.Food2ForkParameterValues.APIKey as AnyObject
        
        // Create session and request
        let session = URLSession.shared
        let request = URLRequest(url: food2ForkURLFor(method: Base.Food2ForkMethods.Get, parameters))
        
        // Make the request
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            // GUARD: Was there an error?
            guard (error == nil) else {
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            // GUARD: Did we get a successful 2XX response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2XX.")
                return
            }
            
            // GUARD: Was there any data returned?
            guard let data = data else {
                sendError("No data was returned by the request.")
                return
            }
            
            self.convertDataWithCompletionHandler(data: data, completionHandlerForConvertData: completionHandlerForGET)
        }
        // Start the request
        task.resume()
    }
    // MARK: Search
    
    func taskForSEARCHMethod(method: String, parameters: [String: AnyObject], completionHandlerForGET: @escaping (_ result: [String: AnyObject]?, _ error: NSError?) -> Void) {
        // Setting the parameters
        var parameters = parameters
        parameters[Base.Food2ForkParameterKeys.APIKey] = Base.Food2ForkParameterValues.APIKey as AnyObject
        
        // Create session and request
        let session = URLSession.shared
        let request = URLRequest(url: food2ForkURLFor(method: Base.Food2ForkMethods.Search, parameters))
        
        // Make the request
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGET(nil, NSError(domain: "taskForSEARCHMethod", code: 1, userInfo: userInfo))
            }
            
            // GUARD: Was there an error?
            guard (error == nil) else {
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            // GUARD: Did we get a successful 2XX response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2XX.")
                return
            }
            
            // GUARD: Was there any data returned?
            guard let data = data else {
                sendError("No data was returned by the request.")
                return
            }
            
            self.convertDataWithCompletionHandler(data: data, completionHandlerForConvertData: completionHandlerForGET)
        }
        // Start the request
        task.resume()
    }
    
    private func convertDataWithCompletionHandler(data: Data, completionHandlerForConvertData: (_ result: [String: AnyObject]?, _ error: NSError?) -> Void) {
        
        var parsedResult: [String: AnyObject]
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
            completionHandlerForConvertData(parsedResult, nil)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
    }
    // MARK: Helper for Creating a URL from Parameters
    private func food2ForkURLFor(method: String, _ parameters: [String: AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Base.Food2Fork.APIScheme
        components.host = Base.Food2Fork.APIHost
        
        if method == Base.Food2ForkMethods.Get {
            components.path = Base.Food2Fork.APIPathGet
        } else if method == Base.Food2ForkMethods.Search {
            components.path = Base.Food2Fork.APIPathSearch
        }
        
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        return components.url!
    }
}
