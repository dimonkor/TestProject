//
// Created by nikolay on 4/5/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

void NSUserDefaultsSetBool(BOOL value, NSString *key);

void NSUserDefaultsSetObject(id value, NSString *key);

void NSUserDefaultsSetInteger(NSInteger value, NSString *key);

id NSUserDefaultsObjectForKey(NSString *key);

BOOL NSUserDefaultsBoolForKey(NSString *key);

NSInteger NSUserDefaultsIntegerForKey(NSString *key);
