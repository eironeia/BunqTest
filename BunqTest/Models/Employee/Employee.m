//  Created by Alex Cuello on 23/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

#import "Employee.h"

static NSUInteger const kStartingSalary = 10000;
NSString* const kSalaryCurrency = @"JPY";
@implementation Employee
- (instancetype)initWithName:(NSString*)name birthYear:(NSUInteger)birthYear {
    self = [super init];
    if(self) {
        _name = name;
        _birthYear = birthYear;
        _salary = [[NSDecimalNumber alloc] initWithUnsignedInteger:kStartingSalary];
    }
    return self;
}
-(NSString *)salaryWithCurrency {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.currencyCode = kSalaryCurrency;
    return [formatter stringFromNumber:_salary];
}
@end
