//
// Created by dimka on 1/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

/**
 * Creates a mutable array which does not retain references to the objects it contains.
 *
 * Typically used with arrays of delegates.
 */
NSMutableArray *COCreateNonRetainingMutableArray();

void dispatch_in_main_queue(dispatch_block_t block);
