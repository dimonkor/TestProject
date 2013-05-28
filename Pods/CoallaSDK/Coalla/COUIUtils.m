//
// Created by nikolay on 7/25/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "COUIUtils.h"

UIColor *UIColorMakeRGB(CGFloat red, CGFloat green, CGFloat blue) {
    return UIColorMakeRGBWithAlpha(red, green, blue, 1.0f);
}

UIColor *UIColorMakeRGBWithAlpha(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

UILabel *UILabelMake(NSString *text, NSString *font, int size, UIColor *color) {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:font size:size];
    if (color) {
        label.textColor = color;
    }
    label.text = text;
    [label sizeToFit];
    return label;
}

CGPoint COViewCenter(UIView *view) {
    return CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
}

UIColor *COPatternBgColor(NSString *imageName) {
    UIImage *bgImage = [UIImage imageNamed:imageName];
    return [[UIColor alloc] initWithPatternImage:bgImage];
}

@implementation COUIUtils

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end