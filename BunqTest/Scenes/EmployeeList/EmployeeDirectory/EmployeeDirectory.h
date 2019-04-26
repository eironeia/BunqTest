//  Created by Alex Cuello on 23/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

#import <Foundation/Foundation.h>
// notification posted when the directory finishes updating
extern NSString* const kEmployeeDirectoryDidUpdateNotification;
@interface EmployeeDirectory : NSObject
@property (readonly) NSArray* employees; // returns NSArray of Employee
@property (readonly) BOOL isUpdating;
- (void)update;
@end
