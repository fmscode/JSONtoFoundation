//
//  AppDelegate.h
//  JSONtoFoundation
//
//  Created by Frank Michael on 12/17/13.
//  Copyright (c) 2013 Frank Michael. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSTextField *objectName;

- (IBAction)convertText:(id)sender;
@end
