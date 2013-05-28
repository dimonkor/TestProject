//
// Created by nikolay on 7/25/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

UIColor *UIColorMakeRGB(CGFloat red, CGFloat green, CGFloat blue);

UIColor *UIColorMakeRGBWithAlpha(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);

UILabel *UILabelMake(NSString *text, NSString *font, int size, UIColor *color);

CGPoint COViewCenter(UIView *view);

UIColor *COPatternBgColor(NSString *imageName);

@interface COUIUtils : NSObject

+ (NSString *)appVersion;

@end