//
//  TPViewController.m
//  TestProject
//
//  Created by Дмитрий Коротченков on 5/28/13.
//  Copyright (c) 2013 Дмитрий Коротченков. All rights reserved.
//

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
    NSDictionary *dictionary = [TPViewController viewInfo:self.view];
    NSLog(@"%@", [TPViewController jsonViewInfo:self.view]);
}


+ (NSDictionary *)viewInfo:(UIView *)view {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *properties = @[@"frame"];
    for (NSUInteger i = 0; i < properties.count; i++) {
        NSString *key = properties[i];
//        id value = [view performSelector:NSSelectorFromString(key)];
        CGRect value = [view frame];
        [dictionary setValue:[NSValue valueWithCGRect:value] forKey:key];
    }
    NSMutableArray *subviews = [NSMutableArray array];
    for (NSUInteger i = 0; i < view.subviews.count; i++) {
        [subviews addObject:[self viewInfo:[view.subviews objectAtIndex:i]]];
    }
    [dictionary setValue:subviews forKey:@"subviews"];
    return dictionary;
}

+ (NSMutableString *)jsonViewInfo:(UIView *)view {
    NSMutableString *string = [@"{" mutableCopy];
    NSArray *properties = @[@"frame"];
    for (NSUInteger i = 0; i < properties.count; i++) {
        NSString *key = @"frame";
        NSString *value = NSStringFromCGRect(view.frame);

        [string appendFormat:@"\"%@\":\"%@\"", key, value];
        if (i != properties.count - 1 || view.subviews.count > 0) {
            [string appendString:@","];
        }
    }
    if (view.subviews.count > 0) {
        [string appendString:@"\"subviews\":["];
        for (NSUInteger i = 0; i < view.subviews.count; i++) {
            [string appendString:[self jsonViewInfo:[view.subviews objectAtIndex:i]]];
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
