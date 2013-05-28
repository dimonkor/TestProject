//
//  Created by dp on 5/31/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#define KB_TOOLBAR_PREV_BTN_INDEX 0
#define KB_TOOLBAR_NEXT_BTN_INDEX 1

@interface COKeyboardToolbar : UIToolbar

@property(nonatomic, strong) UISegmentedControl *segmentedControl;

- (id)initWithDelegate:(id)delegate;

@end