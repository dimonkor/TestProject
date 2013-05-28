//
//  Created by dp on 6/1/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#define EDIT_FIELDS_VIEW_TAG 1000

#define TEXT_DID_BEGIN_EDITING_NOTIFICATION @"TEXT_DID_BEGIN_EDITING_NOTIFICATION"
#define GO_BTN_PRESSED_NOTIFICATION @"GO_BTN_PRESSED_NOTIFICATION"


@interface COEditFieldsView : UIScrollView <UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic) UIView *activeField;
@property(nonatomic, strong) NSMutableArray *textFields;

- (void)addTextField:(UITextField *)textField;

- (void)addTextView:(UITextView *)textView;

- (void)scrollToSelectedRangeForTextView:(UITextView *)textView;

@end