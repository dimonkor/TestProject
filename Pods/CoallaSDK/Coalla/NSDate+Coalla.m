//
// Created by Дмитрий Коротченков on 4/10/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSDate+Coalla.h"

@implementation NSDate (Coalla)

- (NSString *)toStringWithFormat:(NSString *)format {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:self];
}

@end