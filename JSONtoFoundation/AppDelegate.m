//
//  AppDelegate.m
//  JSONtoFoundation
//
//  Created by Frank Michael on 12/17/13.
//  Copyright (c) 2013 Frank Michael. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    // Insert code here to initialize your application
}

- (IBAction)convertText:(id)sender{
    // Get json string from text view.
    NSString *json = _textView.string;
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    // Convert JSON data to foundation.
    NSError *convertError;
    NSDictionary *jsonFound = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&convertError];
    if (!convertError){
        // Get basic NSObject template
        NSString *headerPath = [[NSBundle mainBundle] pathForResource:@"object.h" ofType:@"txt"];
        NSString *impPath = [[NSBundle mainBundle] pathForResource:@"object.m" ofType:@"txt"];
        NSString *objectHeader = [[NSString alloc] initWithContentsOfFile:headerPath encoding:NSUTF8StringEncoding error:nil];
        NSString *objectImp = [[NSString alloc] initWithContentsOfFile:impPath encoding:NSUTF8StringEncoding error:nil];
        // Add Object name to files.
        objectHeader = [objectHeader stringByReplacingOccurrencesOfString:@"[object_name]" withString:_objectName.stringValue];
        objectImp = [objectImp stringByReplacingOccurrencesOfString:@"[object_name]" withString:_objectName.stringValue];
        // Generate properties.
        NSString __block *objectProps = @"";
        NSArray *orderedKeys = [[jsonFound allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        [orderedKeys enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
            // Pull out property obj
            id object = jsonFound[key];
            if ([object isKindOfClass:[NSArray class]]){
                objectProps = [objectProps stringByAppendingString:[NSString stringWithFormat:@"@property (nonatomic,strong)NSArray *%@;\n",[self removeUnderscores:key]]];
            }else if ([object isKindOfClass:[NSNumber class]]){
                objectProps = [objectProps stringByAppendingString:[NSString stringWithFormat:@"@property (nonatomic,strong)NSNumber *%@;\n",[self removeUnderscores:key]]];
            }else{
                objectProps = [objectProps stringByAppendingString:[NSString stringWithFormat:@"@property (nonatomic,strong)NSString *%@;\n",[self removeUnderscores:key]]];
            }
        }];
        // Add Object properties
        objectHeader = [objectHeader stringByReplacingOccurrencesOfString:@"[object_props]" withString:objectProps];
        // Save all data to the Desktop.
        NSError *headWriteError;
        NSError *impWriteError;
        BOOL headerStatus = [objectHeader writeToFile:[[NSString stringWithFormat:@"~/Desktop/%@.h",_objectName.stringValue] stringByExpandingTildeInPath] atomically:YES encoding:NSUTF8StringEncoding error:&headWriteError];
        BOOL impStatus = [objectImp writeToFile:[[NSString stringWithFormat:@"~/Desktop/%@.m",_objectName.stringValue] stringByExpandingTildeInPath] atomically:YES encoding:NSUTF8StringEncoding error:&impWriteError];
        // Log any errors.
        if (!headerStatus){
            NSLog(@"%@",headWriteError.description);
        }else if (!impStatus){
            NSLog(@"%@",impWriteError.description);
        }
    }else{
        // JSON convert error.
        NSLog(@"%@",convertError.description);
    }
}
// Removes any underscores and reformats property. i.e. first_name => firstName
- (NSString *)removeUnderscores:(NSString *)string{
    if ([string rangeOfString:@"_"].location != NSNotFound){
        NSUInteger underScoreRange = [string rangeOfString:@"_"].location;
        NSString *beforeUnder = [string substringToIndex:underScoreRange];
        NSString *afterUnder = [[string substringFromIndex:underScoreRange+1] capitalizedString];
        NSString *cleaned = [NSString stringWithFormat:@"%@%@",beforeUnder,afterUnder];
        if ([cleaned rangeOfString:@"_"].location != NSNotFound){
            cleaned = [self removeUnderscores:cleaned];
            return cleaned;
        }
        return cleaned;
    }
    return string;
}

@end
