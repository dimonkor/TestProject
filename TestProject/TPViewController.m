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
    return [NSString stringWithFormat:@"(X: %.1f, Y: %.1f; W: %.1f, H: %.1f)",
                                      rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

+ (NSString *)descriptionFromBOOL:(BOOL)arg {
    return arg ? @"YES" : @"NO";
}

+ (NSString *)valueForKey:(NSString *)key forView:(UIView *)view {
    if ([key isEqualToString:@"frame"]) {
        return [self descriptionFromRect:view.frame];

    } else if ([key isEqualToString:@"bounds"]) {
        return [self descriptionFromRect:view.bounds];

    } else if ([key isEqualToString:@"hidden"]) {
        return [self descriptionFromBOOL:view.hidden];

    } else if ([key isEqualToString:@"alpha"]) {
        return [NSString stringWithFormat:@"%.1f", view.alpha];

    } else if ([key isEqualToString:@"opaque"]) {
        return [self descriptionFromBOOL:view.opaque];;

    } else if ([key isEqualToString:@"clipsToBounds"]) {
        return [self descriptionFromBOOL:view.clipsToBounds];

    } else if ([key isEqualToString:@"tag"]) {
        return [NSString stringWithFormat:@"%d", view.tag];

    } else if ([key isEqualToString:@"backgroundColor"]) {
        return view.backgroundColor.description;

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

        [string appendFormat:@"\"%@\":\"%@\"", key, value];
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
