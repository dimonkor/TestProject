//
// Created by dp on 4/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "COCommonMetrics.h"

CGFloat COStatusBarHeight() {
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];

    // We take advantage of the fact that the status bar will always be wider than it is tall
    // in order to avoid having to check the status bar orientation.
    CGFloat statusBarHeight = MIN(statusBarFrame.size.width, statusBarFrame.size.height);

    return statusBarHeight;
}
