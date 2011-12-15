//
//  ComponentDetails.m
//

#import "ComponentDetails.h"
#import "Component.h"
#import "Blob.h"
#import "CellData.h"
#import "Image.h"

@implementation ComponentDetails

@synthesize component;

#pragma mark -
#pragma mark View lifecycle

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	CellData *cd = [[component.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    
    if (cd.image) {
        Image *i = [[Image alloc] initWithNibName:@"Image" bundle:nil];
        i.image = cd.image;
        [self.navigationController pushViewController:i animated:YES];
        [i release];
        return;
    }
    
    Blob *b = [[Blob alloc] initWithNibName:@"Blob" bundle:nil];
    
    if (cd.description) {
        b.key = cd.text;
        b.value = cd.description;
    } else {
        b.key = @"Body";
        b.value = cd.text;
        
    }
	[self.navigationController pushViewController:b animated:YES];
	[b release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Details";
}


- (void) replay: (UIButton *)sender {
    NSLog(@"ouch");
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (component.response) {
        return;
    }
    
    // toolbar
	UIBarButtonItem *spaceItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	UIBarButtonItem *replay =  [[[UIBarButtonItem alloc] initWithTitle:@"Refetch" style:UIBarButtonItemStyleBordered target:self action:@selector(replay:)] autorelease];
	self.toolbarItems = [NSArray arrayWithObjects: spaceItem, replay, nil];

    [self.navigationController setToolbarHidden:NO animated:YES];

}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSArray *secs = component.sectionTitles;
	return [secs objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [component.sectionTitles count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    return [[component.data objectAtIndex:section] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CellData *cd = [[component.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    
    
    if (cd.description) {    
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"withdesc"] autorelease];
        
        cell.textLabel.text = cd.text;
        cell.detailTextLabel.text = cd.description;
        return cell;
    }

    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"] autorelease];
    if (cd.image) {
        cell.imageView.image = cd.image;
    } else {
        cell.textLabel.text = cd.text;
    }
    
    return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

