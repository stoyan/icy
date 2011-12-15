//
//  ComponentDetails.h
//

#import <UIKit/UIKit.h>
#import "Component.h"


@interface ComponentDetails : UITableViewController {}

@property (nonatomic, retain) Component *component;

- (void) replay: (UIButton *)sender;

@end
