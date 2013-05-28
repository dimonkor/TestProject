//
// Created by mb on 27.12.12.
//


#import "COTextUtils.h"

NSString *trimPunctuation(NSString *originalString) {
    if (!originalString)
        return originalString;
    NSMutableCharacterSet *set = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [set formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
    return [originalString stringByTrimmingCharactersInSet:set];
}

@implementation COTextUtils

+ (BOOL)isBlank:(NSString *)string {
    if (!string) {
        string = @"";
    }
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return string.length == 0;
}

+ (BOOL)isValidEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *)safeString:(NSString *)string {
    return string ? string : @"";
}

+ (NSString *)pluralize:(NSUInteger)num firstForm:(NSString *)form1 secondForm:(NSString *)form2 thirdForm:(NSString *)form5 {

    NSUInteger n = num % 100;
    NSUInteger n1 = num % 10;

    if (n > 10 && n < 20)
        return form5;

    else if (n1 > 1 && n1 < 5)
        return form2;

    else if (n1 == 1)
        return form1;

    else return form5;
}

@end