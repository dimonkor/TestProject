//
//  Created by dp on 6/1/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class COKeyboardToolbar;


@interface COKeyboardController : UIViewController

@property(nonatomic, strong) COKeyboardToolbar *keyboardToolbar;

- (void)keyboardWillShow:(NSNotification *)aNotification;

- (void)keyboardWillHide:(NSNotification *)aNotification;

- (void)hideKeyboard;


@end