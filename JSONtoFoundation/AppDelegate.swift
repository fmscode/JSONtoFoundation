//
//  AppDelegate.swift
//  JSONtoFoundation
//
//  Created by Frank Michael on 12/28/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

enum FileCreationType {
    case ObjectiveC
    case Swift
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet var jsonTextView: NSTextView!
    @IBOutlet weak var fileNameField: NSTextField!
    @IBOutlet weak var outputTypeSeg: NSSegmentedControl!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func convertJSON(sender: AnyObject) {
        let json = self.jsonTextView.string
        let jsonData = json!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        var convertError: NSError?
        let jsonFoundation = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: &convertError) as NSDictionary
        
        if (convertError == nil) {
            if (self.outputTypeSeg.selectedSegment == 0){
                // Obj-C
                println(self.createPropertiesForFileType(jsonFoundation, type: .ObjectiveC))
            }else{
                // Swift
                println(self.createPropertiesForFileType(jsonFoundation, type: .Swift))
            }
        }else {
            println(convertError?.debugDescription)
        }
    }
    
    func createPropertiesForFileType(data: NSDictionary, type: FileCreationType) -> String {
        
        let keys = data.allKeys as NSArray
        
        let orderedKeys = keys.sortedArrayUsingSelector("caseInsensitiveCompare:") as [String]
        var objectProperties = ""
        for key in orderedKeys {
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
    func applicationShouldHandleReopen(sender: NSApplication!, hasVisibleWindows flag: Bool) -> Bool {
        if flag {
            return false;
        }else {
            self.window.makeKeyAndOrderFront(self)
            return true;
        }
    }

    

}

