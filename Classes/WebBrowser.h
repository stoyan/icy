//
//  WebBrowser.h
//

#import <UIKit/UIKit.h>
#import "CacheMonitor.h"

@interface WebBrowser : UIViewController <UIWebViewDelegate, UITextFieldDelegate> {}

@property (nonatomic, retain) UIWebView *webView;

- (void)loadPage:(id)withUrl;
- (void)showComponents:(id)sender;
- (void)showComponents;
- (void)clearLog: (id)sender;

@end
