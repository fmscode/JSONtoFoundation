# JSONtoFoundation
OS X utility that converts a JSON object to a Foundation object that can be used in Cocoa/Cocoa Touch development. 

## Example
JSON Object:
```JSON
{"id":"18","device_type":"Mobile Card Reader","serial_number":"xxx000xxx"}
```
Objective-C Output:
```Objc
#import <Foundation/Foundation.h>

@interface Device : NSObject

@property (nonatomic,strong)NSString *deviceType;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *serialNumber;

@end
```
Configuration:
To expand/edit the base templates, edit object.h.txt & object.m.txt files. Edit these to add your own name and copyright notice.
