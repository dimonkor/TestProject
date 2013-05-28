//
// Created by dimka on 1/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "COCommonUtils.h"


NSMutableArray *COCreateNonRetainingMutableArray() {
    return (__bridge_transfer NSMutableArray *) CFArrayCreateMutable(nil, 0, nil);
}

void dispatch_in_main_queue(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}
