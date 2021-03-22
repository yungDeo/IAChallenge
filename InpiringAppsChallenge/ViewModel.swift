//
//  ViewModel.swift
//  InpiringAppsChallenge
//
//  Created by Calbert, Deron on 3/7/21.
//

import Foundation

class ViewModel {
    
    let service:Service
    var dictionary:Dictionary<String,[String]> = [:]
    
    private var sequenceCounts:[SequenceCount] = []
    var tableViewSequences:[SequenceCount] {
        return sequenceCounts.sorted(by: {$0.numberOfOccurences > $1.numberOfOccurences})
    }
    
    
    init(service:Service = LogService()) {
        self.service = service
    }
    
    
    func getLogs(completion:@escaping (_ success:Bool)->Void) {
        service.load() {[weak self]
            results in
            
            self?.dictionary = results.reduce([String:[String]]())  { (dictionary:[String:[String]],log:LogModel)-> [String:[String]] in
                var dict = dictionary
                if dict[log.user] == nil {
                    dict[log.user] = [log.page]
                }else {
                    dict[log.user]?.append(log.page)
                }
                
                return dict
                
            }
            self?.sortThreePageSequence(log: self?.dictionary ?? [:])
            completion(true)
        }
    }
    func sortThreePageSequence(log:[String:[String]]){
        var sequences = [[String]]()
        let values = Array(log.values)
        for value in values {
            let numberOfSequences = value.count - 2
            for i in 0..<numberOfSequences {
                let subArray = Array(value[i..<i+3])
                sequences.append(subArray)
            }
        }
        let set = NSCountedSet(array: sequences)
        
        for item in set {
            
            let count = set.count(for: item)
            let sequence =  item as! [String]
            sequenceCounts.append(SequenceCount(sequence: sequence, count: count))
        }
        
    }
    
}

