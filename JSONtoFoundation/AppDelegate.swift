//
//  AppDelegate.swift
//  JSONtoFoundation
//
//  Created by Frank Michael on 12/28/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet var jsonTextView: NSTextView!
    @IBOutlet weak var fileNameField: NSTextField!
    @IBOutlet weak var outputTypeSeg: NSSegmentedControl!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.jsonTextView.automaticDashSubstitutionEnabled = false
        self.jsonTextView.automaticQuoteSubstitutionEnabled = false
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func convertJSON(sender: AnyObject) {
        let json = self.jsonTextView.string
        let jsonData = json!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        var convertError: NSError?
        let jsonFoundation = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: &convertError) as? NSDictionary
        
        if let jsonDic = jsonFoundation {
            if (self.outputTypeSeg.selectedSegment == 0){
                // Obj-C
                println(JSONConverter.createPropertiesForFileType(jsonDic, type: .ObjectiveC))
            }else{
                // Swift
                println(JSONConverter.createPropertiesForFileType(jsonDic, type: .Swift))
            }
        }else {
            let errorAlert = NSAlert()
            var errorMessage = "Invalid JSON"
            if let error = convertError {
                errorMessage = error.localizedDescription
            }
            errorAlert.messageText = errorMessage
            errorAlert.runModal()
        }
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

