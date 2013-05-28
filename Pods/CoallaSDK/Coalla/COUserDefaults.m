//
// Created by nikolay on 4/5/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "COUserDefaults.h"

void NSUserDefaultsSetBool(BOOL value, NSString *key) {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

void NSUserDefaultsSetObject(id value, NSString *key) {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

void NSUserDefaultsSetInteger(NSInteger value, NSString *key) {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

id NSUserDefaultsObjectForKey(NSString *key) {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

BOOL NSUserDefaultsBoolForKey(NSString *key) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

NSInteger NSUserDefaultsIntegerForKey(NSString *key) {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}



