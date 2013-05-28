//
// Created by mb on 27.12.12.
//


#import <Foundation/Foundation.h>

NSString *trimPunctuation(NSString *originalString);

@interface COTextUtils : NSObject

+ (BOOL)isBlank:(NSString *)string;

+ (BOOL)isValidEmail:(NSString *)email;

+ (NSString *)safeString:(NSString *)string;

+ (NSString *)pluralize:(NSUInteger)num firstForm:(NSString *)form1 secondForm:(NSString *)form2 thirdForm:(NSString *)form5;

@end