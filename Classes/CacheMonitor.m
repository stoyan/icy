//
//  CacheMonitor.m
//

#import "CacheMonitor.h"
#import "Component.h"


@implementation CacheMonitor

@synthesize requests, responses, endtimes, components, urls;

+ (CacheMonitor *)getCache 
{
    static CacheMonitor *cache = nil;
    
    if (!cache) {
        // setup cache
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        cache = [[CacheMonitor alloc] initWithMemoryCapacity: 512*1024
                                                diskCapacity: 10*1024*1024 
                                                    diskPath: [[paths objectAtIndex:0] stringByAppendingPathComponent:@"URLCache"]];
        [NSURLCache setSharedURLCache:cache];
    }

    return cache;
}


- (NSCachedURLResponse*)cachedResponseForRequest:(NSURLRequest*)request
{
    // lazy init
	if (!requests) {
		components = [[NSMutableArray alloc] init];
	}
	
	NSString *url = request.URL.absoluteString;

	if (![url hasPrefix:@"data"]) {

		NSLog(@"[Q] %@", url);
				
		Component *c = [[Component alloc] init];
		c.request = request;
		c.start = [NSDate date];
		[components addObject:c];

	}
	
    return [super cachedResponseForRequest:request];
}

- (void)storeCachedResponse:(NSCachedURLResponse *)response forRequest:(NSURLRequest *)request {
	
	// lazy init
	if (!requests) {
		requests = [[NSMutableArray alloc] init];
		responses = [[NSMutableArray alloc] init];
		endtimes = [[NSMutableArray alloc] init];
		urls = [[NSMutableArray alloc] init];

	}
	
	NSString *url = request.URL.absoluteString;
	
	if (![url hasPrefix:@"data"]) {
		[requests  addObject:request];
		[responses addObject:response];
		[endtimes  addObject:[NSDate date]];
		[urls	   addObject:url];
        
        
        
        NSLog(@"[A] %@", url);

	}
	
	[super storeCachedResponse:response forRequest:request];
	
}


- (void) populate {
	for (int i = 0; i < [components count]; i++) {
        Component *c = [components objectAtIndex:i];
		
        if (c.response) {
            continue;
        }
        int index = [requests indexOfObject:c.request];
		
		// sometimes (redirect) the two request objects don't match
		// so we'll try to match them by url
		if (index == NSNotFound) {
			index = [urls indexOfObject:c.request.URL.absoluteString];
		}
		if (index == NSNotFound) {
			continue; // give up
		}
		
		c.response = [responses objectAtIndex:index];
        c.end = [endtimes objectAtIndex:index];
		c.duration = [c.end timeIntervalSinceDate:c.start];
	}	
}

- (void) clearLog {	
	[requests removeAllObjects];
	[responses removeAllObjects];
	[endtimes removeAllObjects];
	[components removeAllObjects];
	[urls removeAllObjects];

	
	[[NSURLCache sharedURLCache] removeAllCachedResponses];
	
}

- (void)dealloc
{
	[requests release];
	[responses release];
	[endtimes release];
	[components release];
	[urls release];
    [super dealloc];
}

@end
