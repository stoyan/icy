//
//  CacheMonitor.h
//

#import <Foundation/Foundation.h>


@interface CacheMonitor : NSURLCache {}

@property (nonatomic, retain) NSMutableArray *components;
@property (nonatomic, retain) NSMutableArray *urls;

@property (nonatomic, retain) NSMutableArray *requests;
@property (nonatomic, retain) NSMutableArray *responses;
@property (nonatomic, retain) NSMutableArray *endtimes;

+ (CacheMonitor *)getCache;

- (void) populate;
- (void) clearLog;

@end
