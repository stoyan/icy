//
//  ComponentsList.m
//

#import "ComponentsList.h"
#import "ComponentDetails.h"
#import "Component.h"


@implementation ComponentsList

@synthesize table;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CacheMonitor *cache = [CacheMonitor getCache];
    return cache.components.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCustomCellID = @"componentcell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCustomCellID] autorelease];
    }

    CacheMonitor *cache = [CacheMonitor getCache];
    Component *comp = [cache.components objectAtIndex:indexPath.row];
    NSString* url = comp.request.URL.absoluteString;
	NSString* title = comp.request.URL.lastPathComponent;

	if ([title isEqualToString:@"/"]) {
		title = comp.request.URL.host;
	}
    cell.textLabel.text = title;
	cell.detailTextLabel.text = url;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	NSString *type = [comp getType];
	if (type != @"image") {
		NSString *img = [@"icon-" stringByAppendingString:type];
		cell.imageView.image = [UIImage imageNamed:img];
	} else {
		cell.imageView.image = [UIImage imageWithData:comp.response.data];
	}
	
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	ComponentDetails *dits = [[ComponentDetails alloc] initWithNibName:@"ComponentDetails" bundle:nil];
    CacheMonitor *cache = [CacheMonitor getCache];
	dits.component = [cache.components objectAtIndex:indexPath.row];
    [dits.component remodel];
	[self.navigationController pushViewController:dits animated:YES];
	[dits release];
}


- (void)viewDidLoad 
{
    [super viewDidLoad];
    CacheMonitor *cache = [CacheMonitor getCache];
	self.title = [@"Components: " stringByAppendingString:[NSString stringWithFormat:@"%lu", [cache.components count]]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[table release];
}


@end
