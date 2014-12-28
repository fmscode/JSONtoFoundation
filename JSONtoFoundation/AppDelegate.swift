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
    
    let swiftTemplate = NSBundle.mainBundle().pathForResource("object.swift", ofType: "txt")!
    let objectiveCH = NSBundle.mainBundle().pathForResource("object.h", ofType: "txt")!
    let objectiveCM = NSBundle.mainBundle().pathForResource("object.m", ofType: "txt")!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.jsonTextView.automaticDashSubstitutionEnabled = false
        self.jsonTextView.automaticQuoteSubstitutionEnabled = false
        self.jsonTextView.string = "{\"id\":\"file\",\"value\": \"File\",\"menuitem\": []}"
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func convertJSON(sender: AnyObject) {
        let json = self.jsonTextView.string
        var fileName = self.fileNameField.stringValue
        let jsonData = json!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        var convertError: NSError?
        let jsonFoundation = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: &convertError) as? NSDictionary
        
        if let jsonDic = jsonFoundation {
            var outputContent = ""
            if (self.outputTypeSeg.selectedSegment == 0){
                // Obj-C
                outputContent = JSONConverter.createPropertiesForFileType(jsonDic, type: .ObjectiveC)
            }else{
                // Swift
                outputContent = JSONConverter.createPropertiesForFileType(jsonDic, type: .Swift)
                var swiftFile = NSString(contentsOfFile: self.swiftTemplate, encoding: NSUTF8StringEncoding, error: nil)
                swiftFile = swiftFile?.stringByReplacingOccurrencesOfString("[object_name]", withString: fileName)
                swiftFile = swiftFile?.stringByReplacingOccurrencesOfString("[object_props]", withString: outputContent)
                
                let save = NSSavePanel()
                save.nameFieldStringValue = "\(fileName).swift"
                save.runModal()
                
                if let url = save.URL {
                    if let swiftContents = swiftFile {
                        swiftContents.writeToFile(url.path!, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
                    }
                }
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

