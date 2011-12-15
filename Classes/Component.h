//
//  Component.h
//

#import <Foundation/Foundation.h>


@interface Component : NSObject {

}
@property (nonatomic, retain) NSURLRequest *request;
@property (nonatomic, retain) NSCachedURLResponse *response;
@property (nonatomic)		  NSTimeInterval duration;
@property (nonatomic, retain) NSDate *start;
@property (nonatomic, retain) NSDate *end;

@property (nonatomic, retain) NSString *responseBody;
@property (nonatomic, retain) NSString *requestBody;
@property (nonatomic, retain) NSString *requestMethod; 
@property (nonatomic, retain) NSDictionary *responseHeaders;
@property (nonatomic, retain) NSDictionary *requestHeaders;

@property (nonatomic, retain) NSMutableArray *sectionTitles;
@property (nonatomic, retain) NSMutableArray *data;

- (NSString *) getType;
- (void) remodel;


@end
