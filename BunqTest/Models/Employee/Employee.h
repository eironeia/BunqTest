//  Created by Alex Cuello on 23/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

#import <Foundation/Foundation.h>
@interface Employee : NSObject
@property (readonly, copy) NSString* name;
@property (readonly) NSUInteger birthYear;
@property (readonly, copy) NSDecimalNumber* salary;
- (instancetype)initWithName:(NSString*)name birthYear:(NSUInteger)birthYear;
-(NSString *)salaryWithCurrency;
@end
