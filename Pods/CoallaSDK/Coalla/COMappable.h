//
// Created by nikolay on 6/6/12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#ifdef _RESTKIT_
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class RKObjectMapping;


@interface COMappable : NSObject

+ (RKObjectMapping *)mapping;

@end
#endif