//
//  AppDelegate.swift
//  JSON Convert
//
//  Created by Frank Michael on 8/24/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    let nsHeaderPath = NSBundle.mainBundle().pathForResource("object.h", ofType: "txt")
    let nsImplementationPath = NSBundle.mainBundle().pathForResource("object.m", ofType: "txt")
    let swiftPath = NSBundle.mainBundle().pathForResource("object.swift", ofType: "txt")
    
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var jsonTextView: NSTextView!
    @IBOutlet weak var objectNameField: NSTextField!
    @IBOutlet weak var fileTypeSwitch: NSButton!
    
    @IBAction func convertJSON(AnyObject) {
        let json = self.jsonTextView.string
        let jsonData = json.dataUsingEncoding(NSUTF8StringEncoding)
        var convertError: NSError?
        let jsonFoundation = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: &convertError) as NSDictionary
        
        if (convertError != nil) {
            if (self.fileTypeSwitch.state == 0){
                // Adding a NSObject
            }else{
                // Adding a Swift
            }
            
        }else {
            println(convertError?.debugDescription)
        }
    }


    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
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

