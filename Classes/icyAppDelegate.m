//
//  icyAppDelegate.m
//

#import "icyAppDelegate.h"
#import "WebBrowser.h"
#import "CacheMonitor.h"

@implementation icyAppDelegate
@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    [CacheMonitor getCache];
	 
	UINavigationController *nav = [[UINavigationController alloc] init];
	WebBrowser *uiweb = [[WebBrowser alloc] init];
	[nav pushViewController:uiweb animated:NO];
    [uiweb release];
	[window addSubview:nav.view];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
