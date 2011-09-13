//
//  JBContainedURLConnection.m
//  
//
//  Created by Jason Brennan on 11-06-19.
//  Public Domain
//

#import "JBContainedURLConnection.h"

@interface JBContainedURLConnection ()

@property (nonatomic, strong) NSURLConnection *internalConnection;
@property (nonatomic, strong) NSMutableData *internalData;


@end


@implementation JBContainedURLConnection
@synthesize delegate	= _delegate;
@synthesize urlString	= _urlString;
@synthesize userInfo	= _userInfo;
@synthesize internalConnection = _internalConnection;
@synthesize internalData = _internalData;
@synthesize completionHandler = _completionHandler;


- (void)dealloc {
    
	NSLog(@"Connection dealloc");
	[self.internalConnection cancel];
}


- (id)initWithURLString:(NSString *)urlString userInfo:(NSDictionary *)userInfo delegate:(id<JBContainedURLConnectionDelegate>)delegate {
	
	if ((self = [super init])) {
		self.urlString = urlString;
		self.userInfo = userInfo;
		_delegate = delegate;
		
		
		// Set off the connection
		NSURL *url = [NSURL URLWithString:urlString];
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
		
		self.internalData = [NSMutableData data];
		
		self.internalConnection = [NSURLConnection connectionWithRequest:request delegate:self];
		
		
	}
	
	return self;
	
}


- (id)initWithURLString:(NSString *)urlString userInfo:(NSDictionary *)userInfo completionHandler:(JBContainedURLConnectionCompletionHandler)handler {
	
	if ((self = [super init])) {
		
		self.urlString = urlString;
		self.userInfo = userInfo;
		_completionHandler = handler; // readonly, no setter!
		
		
		// Set off the connection
		NSURL *url = [NSURL URLWithString:urlString];
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
		
		
		self.internalData = [NSMutableData data];
		self.internalConnection = [NSURLConnection connectionWithRequest:request delegate:self];
		
		
	}
	
	return self;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[self.internalData setLength:0];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[self.delegate HTTPConnection:self didFailWithError:error];
	
	if (self.completionHandler) {
		self.completionHandler(self, error, self.urlString, self.userInfo, nil);
	}
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.internalData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[self.delegate HTTPConnection:self didCompleteForURL:self.urlString userInfo:self.userInfo completedData:[NSData dataWithData:self.internalData]];
	
	if (self.completionHandler) {
		self.completionHandler(self, nil, self.urlString, self.userInfo, [NSData dataWithData:self.internalData]);
	}
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	// Cleanup. Handy if you modify this class to support multiple connections from the same instance.
	self.internalData = nil;
	self.internalConnection = nil;
}



- (void)cancel {
	
	[self.internalConnection cancel];
	
	self.internalConnection = nil;
	self.internalData = nil;
	
}












@end
