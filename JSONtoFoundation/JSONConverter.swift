//
//  JSONConverter.swift
//  JSONtoFoundation
//
//  Created by Frank Michael on 12/28/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Foundation

enum FileCreationType {
    case ObjectiveC
    case Swift
}

class JSONConverter: NSObject {

    class func createPropertiesForFileType(data: NSDictionary, type: FileCreationType) -> String {
        
        let keys = data.allKeys as NSArray
        
        let orderedKeys = keys.sortedArrayUsingSelector("caseInsensitiveCompare:") as [String]
        var objectProperties = ""
        for key in orderedKeys {
            objectProperties += "   "
            let object: AnyObject? = data[key]
            
            var propertyName = key.underscoreReplacement()
            if (object? is NSArray) {
                if type == FileCreationType.Swift {
                    objectProperties += "var \(propertyName): [AnyObject]?"
                }else{
                    objectProperties += "@property (nonatomic)NSArray *\(propertyName);"
                }
            }else if (object? is NSNumber) {
                if type == FileCreationType.Swift {
                    objectProperties += "var \(propertyName): Int?"
                }else{
                    objectProperties += "@property (nonatomic)NSNumber *\(propertyName);"
                }
            }else {
                if type == FileCreationType.Swift {
                    objectProperties += "var \(propertyName): String?"
                }else{
                    objectProperties += "@property (nonatomic)NSString *\(propertyName);"
                }
            }
            objectProperties += "\n"
        }
        
        return objectProperties
    }

   
}
