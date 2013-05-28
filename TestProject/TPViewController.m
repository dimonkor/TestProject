//
//  TPViewController.m
//  TestProject
//
//  Created by Дмитрий Коротченков on 5/28/13.
//  Copyright (c) 2013 Дмитрий Коротченков. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "TPViewController.h"

@interface TPViewController ()

@end

@implementation TPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray *params = @[@"backgroundColor", @"frame", @"opaque", @"alpha", @"hidden", @"opaque", @"clipsToBounds", @"tag"];
    NSLog(@"%@", [TPViewController JSONDescription:self.view params:params]);
}

+ (NSString *)descriptionFromRect:(CGRect)rect {
    return [NSString stringWithFormat:@"{\"X\":\"%d\",\"Y\":\"%d\",\"W\":\"%d\",\"H\":\"%d\"}",
                    (int)roundf(rect.origin.x), (int)roundf(rect.origin.y), (int)roundf(rect.size.width), (int)roundf(rect.size.height)];
}

+ (NSString *)descriptionFromColor:(UIColor *)color {
    const float*components = CGColorGetComponents( color.CGColor );
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    CGFloat alpha = components[3];
    return [NSString stringWithFormat:@"\"%2X%02X%02X%2X\"",
                    (int)roundf(red * 255), (int)roundf(green * 255), (int)roundf(blue * 255), (int)roundf(255 * alpha)];
}

+ (NSString *)descriptionFromBOOL:(BOOL)arg {
    return arg ? @"\"true\"" : @"\"false\"";
}

+ (NSString *)valueForKey:(NSString *)key forView:(UIView *)view {
    if ([key isEqualToString:@"frame"]) {
        return [self descriptionFromRect:view.frame];

    } else if ([key isEqualToString:@"bounds"]) {
        return [self descriptionFromRect:view.bounds];

    } else if ([key isEqualToString:@"hidden"]) {
        return [self descriptionFromBOOL:view.hidden];

    } else if ([key isEqualToString:@"alpha"]) {
        return [NSString stringWithFormat:@"\"%.1f\"", view.alpha];

    } else if ([key isEqualToString:@"opaque"]) {
        return [self descriptionFromBOOL:view.opaque];;

    } else if ([key isEqualToString:@"clipsToBounds"]) {
        return [self descriptionFromBOOL:view.clipsToBounds];

    } else if ([key isEqualToString:@"tag"]) {
        return [NSString stringWithFormat:@"\"%d\"", view.tag];

    } else if ([key isEqualToString:@"backgroundColor"]) {
        return [self descriptionFromColor:view.backgroundColor];

    } else {
        return @"";
    }
}

+ (NSMutableString *)JSONDescription:(UIView *)view params:(NSArray *)params {
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"{"];

    for (NSUInteger i = 0; i < params.count; i++) {
        NSString *key = [params objectAtIndex:i];
        NSString *value = [self valueForKey:key forView:view];

        if (!value.length)
            continue;

        [string appendFormat:@"\"%@\":%@", key, value];
        if (i != params.count - 1 || view.subviews.count > 0) {
            [string appendString:@","];
        }
    }

    if (view.subviews.count > 0) {
        [string appendString:@"\"subviews\":["];
        for (NSUInteger i = 0; i < view.subviews.count; i++) {
            [string appendString:[self JSONDescription:[view.subviews objectAtIndex:i] params:params]];
            if (i != view.subviews.count - 1) {
                [string appendString:@","];
            }
        }
        [string appendString:@"]"];
    }
    [string appendString:@"}"];
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
