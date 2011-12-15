//
//  WebBrowser.m
//

#import "WebBrowser.h"
#import "ComponentsList.h"
#import "icyAppDelegate.h"

static bool clearinglog = false;

@implementation WebBrowser

@synthesize webView;


- (void)loadPage:(id)withUrl {
	NSString *userURL = (NSString *)withUrl;
	NSURL *url = [NSURL URLWithString:userURL];
	if (!url.scheme) {
		NSString *myURL = [@"http://" stringByAppendingString:userURL];
		[url initWithString:myURL];
	}
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[webView loadRequest:requestObj];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// address bar business
	CGRect frame = CGRectMake(5, 7, 310, 31);
	UITextField *urlField = [[UITextField alloc] initWithFrame:frame];
	urlField.borderStyle = UITextBorderStyleRoundedRect;
	urlField.delegate = self;
	urlField.placeholder = @"http://";
	urlField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	urlField.returnKeyType = UIReturnKeyGo;
	urlField.keyboardType = UIKeyboardTypeURL;    // this makes the keyboard more friendly for typing URLs
	urlField.autocapitalizationType = UITextAutocapitalizationTypeNone;   // don't capitalize
	urlField.autocorrectionType = UITextAutocorrectionTypeNo; // we don't like autocompletion while typing
	urlField.clearButtonMode = UITextFieldViewModeAlways;
	urlField.adjustsFontSizeToFitWidth = YES;
	urlField.minimumFontSize = 17.0;
	self.navigationItem.titleView = urlField;
		
	// toolbar
	UIBarButtonItem *spaceItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	UIBarButtonItem *clearLog =  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearLog:)] autorelease];
	UIBarButtonItem *spaceItem2 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil] autorelease];
	spaceItem2.width = 30.0;
	UIBarButtonItem *curlPage =  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showComponents:)] autorelease];
	self.toolbarItems = [NSArray arrayWithObjects: spaceItem, clearLog, spaceItem2, curlPage, nil];
	
	[self.navigationController setToolbarHidden:NO animated:YES];
	
	// for the back button on the next view
	self.title = @"Browser";
	
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setToolbarHidden:NO animated:YES];
    if (!self.webView) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.size.height -= 108;
        self.webView = [[[UIWebView alloc]initWithFrame:frame] autorelease];
        self.webView.scalesPageToFit = YES;
        self.webView.delegate = self;
        [self.view addSubview:self.webView];
    }
    
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    if (clearinglog) {    
        self.webView.delegate = nil;
        [self.webView removeFromSuperview];
        self.webView = nil;

    }
    clearinglog = false;
}


- (BOOL)textFieldShouldReturn:(UITextField *)txt {
	[txt resignFirstResponder];
	[self loadPage:txt.text];
	return YES;
}

- (void) clearLog: (UIButton *)sender {
	
	[[CacheMonitor getCache] clearLog];
    clearinglog = true;
    [self showComponents];

	
}

- (void)showComponents {
	ComponentsList *comps = [[ComponentsList alloc] init];
    
	[[CacheMonitor getCache] populate];
	//comps.components = cache.components;
	[self.navigationController pushViewController:comps animated:YES];
    [comps release];
}

- (void)showComponents:(id)sender {
    [self showComponents];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    NSLog(@"did unload");
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)webViewDidFinishLoad:(UIWebView *)wv {
	NSLog(@"finish load");
	//[wv stringByEvaluatingJavaScriptFromString:@"alert(document.title)"];
	
	
}

- (void)dealloc {
    NSLog(@"dalloc");
    [super dealloc];
}


@end
