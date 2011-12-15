//
//  ComponentsList.h
//

#import <UIKit/UIKit.h>
#import "CacheMonitor.h"

@interface ComponentsList : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *table;
}

@property (nonatomic, retain) IBOutlet UITableView *table;


@end
