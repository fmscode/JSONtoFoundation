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
Swift Output:
```Swift
import Foundation

class test: NSObject {
   var deviceType: String?
   var id: String?
   var serialNumber: String?

}
```
Configuration:
To have your name added to the templates simply edit the user name in the app's preferences window. 
