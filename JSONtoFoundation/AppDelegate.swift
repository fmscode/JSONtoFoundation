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
    @IBOutlet weak var classNameField: NSTextField!
    @IBOutlet weak var outputTypeSeg: NSSegmentedControl!
    
    var preferencesWindow: PreferencesView!
    
    let swiftTemplate = NSBundle.mainBundle().pathForResource("object.swift", ofType: "txt")!
    let objectiveCH = NSBundle.mainBundle().pathForResource("object.h", ofType: "txt")!
    let objectiveCM = NSBundle.mainBundle().pathForResource("object.m", ofType: "txt")!

    // MARK: ApplicationDelegate
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.jsonTextView.automaticDashSubstitutionEnabled = false
        self.jsonTextView.automaticQuoteSubstitutionEnabled = false
        self.jsonTextView.font = NSFont.systemFontOfSize(14)
        self.jsonTextView.string = "{\"id\":\"file\",\"value\": \"File\",\"menuitem\": []}"
        if let fileType = NSUserDefaults.standardUserDefaults().objectForKey("fileType") as? Int {
            self.outputTypeSeg.selectedSegment = fileType
        }
    }
    func applicationWillTerminate(aNotification: NSNotification) {
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
    // MARK: Actions
    @IBAction func convertJSON(sender: AnyObject) {
        let json = self.jsonTextView.string
        var fileName = self.classNameField.stringValue
        if (fileName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0){
            let errorAlert = NSAlert()
            errorAlert.messageText = "You must supply a class name!"
            errorAlert.runModal()
            return
        }
        let jsonData = json!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        var convertError: NSError?
        let jsonFoundation = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: &convertError) as? NSDictionary
        
        if let jsonDic = jsonFoundation {
            var outputContent = ""
            if (self.outputTypeSeg.selectedSegment == 0){
                // Obj-C
                outputContent = JSONConverter.createPropertiesForFileType(jsonDic, type: .ObjectiveC)
                var fileContents = self.fillInTemplateWithData(self.objectiveCH, objectName: fileName, propertiesContent: outputContent)
                // Save Header file
                if let contents = fileContents {
                    let headerStatus = self.saveFileWithContents("\(fileName).h", fileContents: contents)
                    if headerStatus {
                        // Save Implementation
                        let objectiveCImp = self.fillInTemplateWithData(self.objectiveCM, objectName: fileName, propertiesContent: nil)
                        if let impContents = objectiveCImp {
                            let impStatus = self.saveFileWithContents("\(fileName).m", fileContents: impContents)
                        }
                    }else{
                        // Unable to save header file.
                        let errorAlert = NSAlert()
                        errorAlert.messageText = "Unable to save Objective-C Header file!"
                        errorAlert.runModal()
                    }
                }
            }else{
                // Swift
                outputContent = JSONConverter.createPropertiesForFileType(jsonDic, type: .Swift)
                let swiftFile = self.fillInTemplateWithData(self.swiftTemplate, objectName: fileName, propertiesContent: outputContent)
                if let fileContents = swiftFile {
                    self.saveFileWithContents("\(fileName).swift", fileContents: fileContents)
                }
            }
        }else {
            // JSON error handling
            let errorAlert = NSAlert()
            var errorMessage = "Invalid JSON"
            if let error = convertError {
                errorMessage = error.localizedDescription
            }
            errorAlert.messageText = errorMessage
            errorAlert.runModal()
        }
    }
    @IBAction func showPrefs(sender: AnyObject) {
        self.preferencesWindow = PreferencesView(windowNibName: "PreferencesView")
        self.window!.beginSheet(self.preferencesWindow.window!, completionHandler: nil)
    }
    // MARK: File/Template Interaction
    func fillInTemplateWithData(templateName: String,objectName: String,propertiesContent: String?) -> String? {
        let fullName = NSUserDefaults.standardUserDefaults().objectForKey("fullName") as? String
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
        var date = formatter.stringFromDate(NSDate())
        
        var templateContents = NSString(contentsOfFile: templateName, encoding: NSUTF8StringEncoding, error: nil)
        templateContents = templateContents?.stringByReplacingOccurrencesOfString("[object_name]", withString: objectName)
        templateContents = templateContents?.stringByReplacingOccurrencesOfString("[date]", withString: date)
        if let properties = propertiesContent {
            templateContents = templateContents?.stringByReplacingOccurrencesOfString("[object_props]", withString: properties)
        }
        if let name = fullName {
            templateContents = templateContents?.stringByReplacingOccurrencesOfString("[user_name]", withString: name)
        }else{
            templateContents = templateContents?.stringByReplacingOccurrencesOfString("[user_name]", withString: "")
        }
        return templateContents
    }
    func saveFileWithContents(fileName: String,fileContents: String) -> Bool {
        let save = NSSavePanel()
        save.nameFieldStringValue = fileName
        save.runModal()
        
        if let url = save.URL {
            var error: NSError?
            let status = fileContents.writeToFile(url.path!, atomically: true, encoding: NSUTF8StringEncoding, error: &error)

            return status
        }else{
            return false
        }
    }
}

