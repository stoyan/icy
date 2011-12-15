//
//  Component.m
//

#import "Component.h"
#import "CellData.h"

@implementation Component

@synthesize request, response, start, end, duration;
@synthesize requestHeaders, responseHeaders, requestBody, responseBody, requestMethod;
@synthesize sectionTitles, data;

- (NSString *) getType {
	NSString *mime = response.response.MIMEType;
	
	if ([mime hasPrefix:@"image/"]) {
		return @"image";
	}
	if ([mime hasSuffix:@"css"]) {
		return @"css";
	}
	if ([mime hasSuffix:@"javascript"]) {
		return @"js";
	}
	if ([mime hasSuffix:@"html"]) {
		return @"html";
	}
	return @"whatever";
	
}

- (NSDictionary *) getResponseHeaders {
    return [(NSHTTPURLResponse *)response.response allHeaderFields];
}

- (NSString *) getResponseBody {
    return [NSString stringWithUTF8String:[response.data bytes]];
}

- (NSDictionary *) getRequestHeaders {
    return [request allHTTPHeaderFields];
}

- (NSString *) getRequestBody {
    return [NSString stringWithUTF8String:[request.HTTPBody bytes]];
}

- (NSString *) getRequestMethod {
    return request.HTTPMethod;
}

- (void) remodel 
{
    sectionTitles = [[NSMutableArray arrayWithObjects: @"Meta", @"Request headers", nil] retain];
    data = [[[NSMutableArray alloc] init] retain];
    
    NSMutableArray *section = [[NSMutableArray alloc] init];    
    
    // Meta
    [section addObject:[CellData initWithText:@"URL" description:request.URL.absoluteString]];
    [section addObject:[CellData initWithText:@"Method" description:request.HTTPMethod]];

    if (response) {
        [section addObject:[CellData initWithText:@"Status code" 
                                      description:[[NSNumber numberWithInt:[(NSHTTPURLResponse *)response.response statusCode]] stringValue]
                            ]
        ];
        [section addObject:[CellData initWithText:@"Status description" 
                                      description:[NSHTTPURLResponse localizedStringForStatusCode:[(NSHTTPURLResponse *)response.response statusCode]]
                            ]
         ];
        [section addObject:[CellData initWithText:@"Duration" 
                                      description:[NSString stringWithFormat: @"%f", duration]
                            ]
         ];
    }
    
    [data addObject:section];
    
    // Request headers
    section = [[NSMutableArray alloc] init];
    NSDictionary *headers = request.allHTTPHeaderFields;
	NSEnumerator *enumerator = [headers keyEnumerator];
	id key;
	
	while ((key = [enumerator nextObject])) {
        [section addObject:[CellData initWithText:key description:[headers objectForKey:key]]];
	}
    [data addObject:section];
    

    
    
    if (self.requestBody) {
        [sectionTitles addObject:@"Request body"];
        
        section = [[NSMutableArray alloc] init];
        [section addObject:[CellData initWithText:[NSString stringWithUTF8String:[request.HTTPBody bytes]]]];
        [data addObject:section];

    }
    
    if (response) {
        [sectionTitles addObject:@"Response headers"];
        [sectionTitles addObject:@"Response body"];
        
        // Response headers
        section = [[NSMutableArray alloc] init];
        headers = [(NSHTTPURLResponse *)response.response allHeaderFields];
        enumerator = [headers keyEnumerator];
        
        while ((key = [enumerator nextObject])) {
            [section addObject:[CellData initWithText:key description:[headers objectForKey:key]]];
        }
        [data addObject:section];

        // Response body
        section = [[NSMutableArray alloc] init];
        if ([self getType] == @"image") {
            [section addObject:[CellData initWithImage:[UIImage imageWithData:response.data]]];
        } else {            
            NSString *text = [NSString stringWithUTF8String:[response.data bytes]];
            [section addObject:[CellData initWithText:text]];
        }
        [data addObject:section];

        
        
    }
    
    // TODO: cookies
    
}

@end
