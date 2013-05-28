//
//  Created by dp on 5/31/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "COKeyboardToolbar.h"


@implementation COKeyboardToolbar
@synthesize segmentedControl = _segmentedControl;


- (id)initWithDelegate:(id)delegate {
    self = [super initWithFrame:CGRectMake(0, 436, 320, 44)];
    if (self) {
        self.barStyle = UIBarStyleBlack;
        self.translucent = YES;

        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
        self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        self.segmentedControl.momentary = YES;
        [self.segmentedControl addTarget:delegate action:@selector(changeEditorBtnPressed:) forControlEvents:UIControlEventValueChanged];
        UIBarButtonItem *sgmItem = [[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl];

        if ([self.segmentedControl respondsToSelector:@selector(setTitleTextAttributes:forState:)]) {
            UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
            [self.segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }

        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Hide" style:UIBarButtonItemStyleDone target:delegate action:@selector(hideKeyboard)];

        [self setItems:[NSArray arrayWithObjects:sgmItem, flex, doneBtn, nil]];
    }
    return self;
}

@end