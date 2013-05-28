//
//  Created by dp on 6/1/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "COKeyboardController.h"
#import "COKeyboardToolbar.h"
#import "COEditFieldsView.h"

@implementation COKeyboardController

- (void)loadView {
    [super loadView];

    self.keyboardToolbar = [[COKeyboardToolbar alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditorWasChanged:) name:TEXT_DID_BEGIN_EDITING_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBtnPressed:) name:GO_BTN_PRESSED_NOTIFICATION object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    COEditFieldsView *view = [self getEditFieldsView];
    if (view.activeField) {
        [view.activeField resignFirstResponder];
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TEXT_DID_BEGIN_EDITING_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GO_BTN_PRESSED_NOTIFICATION object:nil];
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    COEditFieldsView *editFieldsView = [self getEditFieldsView];
    if (!editFieldsView.activeField) {
        return;
    }

    [self.view.window addSubview:self.keyboardToolbar];

    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat kbHeight = kbSize.height + self.keyboardToolbar.frame.size.height;

    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.keyboardToolbar.frame;
        frame.origin.y = self.view.window.frame.size.height - kbHeight;
        self.keyboardToolbar.frame = frame;
    }];

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight, 0.0);
    editFieldsView.contentInset = contentInsets;
    editFieldsView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.keyboardToolbar.frame;
        frame.origin.y = self.view.window.frame.size.height;
        self.keyboardToolbar.frame = frame;

        COEditFieldsView *editFieldsView = [self getEditFieldsView];
        editFieldsView.contentInset = UIEdgeInsetsZero;
        editFieldsView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }
                     completion:^(BOOL completed) {
                         [self.keyboardToolbar removeFromSuperview];
                     }
    ];
}

- (void)hideKeyboard {
    COEditFieldsView *editFieldsView = [self getEditFieldsView];
    [editFieldsView.activeField resignFirstResponder];
}

- (void)goBtnPressed:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self performSelector:@selector(goBtnPressed) withObject:nil afterDelay:duration];
}

- (void)goBtnPressed {
//    override this in descendant if needed
}

- (void)changeEditorBtnPressed:(id)sender {
    COEditFieldsView *efView = [self getEditFieldsView];
    NSUInteger textFieldIndex = [efView.textFields indexOfObject:efView.activeField];

    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger index = segmentedControl.selectedSegmentIndex;
    if (index == KB_TOOLBAR_PREV_BTN_INDEX) {
        if (textFieldIndex > 0) {
            textFieldIndex -= 1;
        }
    } else {
        if (textFieldIndex < efView.textFields.count - 1) {
            textFieldIndex += 1;
        }
    }

    [[efView.textFields objectAtIndex:(textFieldIndex)] becomeFirstResponder];
}

- (COEditFieldsView *)getEditFieldsView {
    return (COEditFieldsView *) [self.view viewWithTag:EDIT_FIELDS_VIEW_TAG];
}

- (void)textEditorWasChanged:(NSNotification *)aNotification {
    COEditFieldsView *efView = [self getEditFieldsView];
    UISegmentedControl *segmentedControl = self.keyboardToolbar.segmentedControl;
    NSUInteger textFieldIndex = [efView.textFields indexOfObject:efView.activeField];

    if (textFieldIndex == 0) {
        [segmentedControl setEnabled:NO forSegmentAtIndex:KB_TOOLBAR_PREV_BTN_INDEX];
        [segmentedControl setEnabled:YES forSegmentAtIndex:KB_TOOLBAR_NEXT_BTN_INDEX];
    } else if (textFieldIndex == efView.textFields.count - 1) {
        [segmentedControl setEnabled:NO forSegmentAtIndex:KB_TOOLBAR_NEXT_BTN_INDEX];
        [segmentedControl setEnabled:YES forSegmentAtIndex:KB_TOOLBAR_PREV_BTN_INDEX];
    } else {
        [segmentedControl setEnabled:YES forSegmentAtIndex:KB_TOOLBAR_PREV_BTN_INDEX];
        [segmentedControl setEnabled:YES forSegmentAtIndex:KB_TOOLBAR_NEXT_BTN_INDEX];
    }

    CGFloat scrollTop;
    if ([efView.activeField isKindOfClass:[UITextView class]]) {
        [efView performSelector:@selector(scrollToSelectedRangeForTextView:) withObject:efView.activeField afterDelay:0.25];

    } else {
        scrollTop = [(UITextField *) efView.activeField frame].origin.y - 80;
        if (scrollTop > 0) {
            UIScrollView *scrollView = (UIScrollView *) self.view;
            [scrollView setContentOffset:CGPointMake(0.0, scrollTop) animated:YES];
        } else {
            UIScrollView *scrollView = (UIScrollView *) self.view;
            [scrollView setContentOffset:CGPointMake(0.0, 0) animated:YES];
        }
    }

}

@end