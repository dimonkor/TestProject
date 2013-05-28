//
//  Created by dp on 6/1/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "COEditFieldsView.h"

@implementation COEditFieldsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = EDIT_FIELDS_VIEW_TAG;
    }
    return self;
}

- (NSMutableArray *)textFields {
    if (!_textFields) {
        _textFields = [NSMutableArray array];
    }
    return _textFields;
}

- (void)addTextField:(UITextField *)textField {
    textField.returnKeyType = UIReturnKeyGo;
    textField.delegate = self;
    [self.textFields addObject:textField];
    [self addSubview:textField];
}

- (void)addTextView:(UITextView *)textView {
    textView.returnKeyType = UIReturnKeyDefault;
    textView.delegate = self;
    [self.textFields addObject:textView];
    [self addSubview:textView];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.textFields containsObject:textField]) {
        self.activeField = textField;
        [[NSNotificationCenter defaultCenter] postNotificationName:TEXT_DID_BEGIN_EDITING_NOTIFICATION object:nil];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.activeField == textField) {
        self.activeField = nil;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:GO_BTN_PRESSED_NOTIFICATION object:nil];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.textFields containsObject:textView]) {
        self.activeField = textView;
        [[NSNotificationCenter defaultCenter] postNotificationName:TEXT_DID_BEGIN_EDITING_NOTIFICATION object:nil];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.activeField == textView) {
        self.activeField = nil;
    }
}

// This method allows to scroll to caret position of textView
- (void)scrollToSelectedRangeForTextView:(UITextView *)textView {
    CGFloat scrollTop;
    CGPoint globalPosition = [textView.superview convertPoint:textView.frame.origin toView:self];
    if ([textView respondsToSelector:@selector(selectedTextRange)]) {
        if (textView.selectedTextRange) {
            scrollTop = globalPosition.y + [textView caretRectForPosition:textView.selectedTextRange.end].origin.y - 100;

        } else {
            scrollTop = globalPosition.y - 100;
        }

    } else {
        // UITextView conforms to UITextInput starting with iOS 5, so we should use another approach for iOS 4
        NSString *tmp;
        if (textView.selectedRange.length + textView.selectedRange.location == 0) {
            tmp = @"aa";
        } else {
            tmp = [textView.text substringToIndex:textView.selectedRange.location + textView.selectedRange.length];
        }
        CGSize constrainedSize = CGSizeMake(textView.frame.size.width, CGFLOAT_MAX);
        CGSize size = [tmp sizeWithFont:textView.font
                      constrainedToSize:constrainedSize
                          lineBreakMode:UILineBreakModeWordWrap];
        scrollTop = size.height - [@"W" sizeWithFont:textView.font].height + globalPosition.y - 100;
    }
    scrollTop = scrollTop - textView.contentOffset.y;
    if (scrollTop > 0) {
        [self setContentOffset:CGPointMake(0.0, scrollTop) animated:YES];
    } else {
        [self setContentOffset:CGPointMake(0.0, 0) animated:YES];
    }
}

@end