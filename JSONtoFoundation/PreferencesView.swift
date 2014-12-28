//
//  PreferencesView.swift
//  JSONtoFoundation
//
//  Created by Frank Michael on 12/28/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class PreferencesView: NSWindowController {
    
    let nameKey = "fullName"
    let fileTypeKey = "fileType"

    @IBOutlet weak var fullNameField: NSTextField!
    @IBOutlet weak var fileTypeSeg: NSSegmentedControl!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        if let fullName = NSUserDefaults.standardUserDefaults().objectForKey(self.nameKey) as? String {
            self.fullNameField.stringValue = fullName
        }
        if let fileType = NSUserDefaults.standardUserDefaults().objectForKey(self.fileTypeKey) as? Int {
            self.fileTypeSeg.selectedSegment = fileType
        }
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(self.fullNameField.stringValue, forKey: self.nameKey)
        NSUserDefaults.standardUserDefaults().setObject(self.fileTypeSeg.selectedSegment, forKey: self.fileTypeKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        self.closeSettings(sender)
    }
    @IBAction func closeSettings(sender: AnyObject) {
        self.window!.sheetParent!.endSheet(self.window!)
    }

}
