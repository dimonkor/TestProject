//
// Created by Дмитрий Коротченков on 4/18/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface UIView (Coalla)

@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

@property CGFloat height;
@property CGFloat width;

- (CGPoint)innerCenter;

- (CGFloat)innerCenterX;

- (CGFloat)innerCenterY;
@end