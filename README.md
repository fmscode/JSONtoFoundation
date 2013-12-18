JSONtoFoundation
================
Take a JSON object and convert it to a Foundation object and export to class files. The files will be saved to your Desktop.

JSON Object:
```JSON
{"id":"18","device_type":"Mobile Card Reader","serial_number":"xxx000xxx"}
```
NSObject Output:
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
