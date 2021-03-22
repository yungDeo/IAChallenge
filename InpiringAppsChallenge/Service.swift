//
//  Service.swift
//  InpiringAppsChallenge
//
//  Created by Calbert, Deron on 3/7/21.
//

import Foundation

protocol Service {
    func load(completetion:@escaping(_ results:[LogModel]) ->Void)
}

class LogService:Service {
    
    init() {}
    
    func load(completetion:@escaping (_ results:[LogModel]) ->Void) {
        let url = URL(string: "http://dev.inspiringapps.com/Files/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log")!
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
            if (error == nil) {
                // Success
                
                
                guard let logs = String(data: data, encoding: .ascii) else { return}
                
                var allLogs:[LogModel] = []
                let logssplit = logs.split(separator: "\n")
                
                for log in logssplit {
                    allLogs.append( self.dirtyParser(apache: String(log)))
                }
                
                completetion(allLogs)
            }
        })
        
        task.resume()
    }
    
    
    func dirtyParser(apache:String) ->LogModel {
        var user:String = ""
        var page:String = ""
        
        user = String(apache.split(separator: "-")[0])
        page = String(apache.split(separator: "-")[3].split(separator: "\"")[1])
        
        return LogModel(page: page, user:user)
        
    }
    
    
}
