JBContainedURLConnection
========================

This is a wrapper class around NSURLConnection with a much simplified API. It gives the benefits of an asynchronous NSURLConnection load without the downsides of having to reimplimplement the same delegate callbacks over and over again. It reduces the boilerplate.

It allows for you to provide a Block object completion handler, or use a simpler set of delegate methods.

Requirements
------------

iOS 5.0 or greater, as it makes use of Automatic Reference Counting and the newer formal `NSURLConnectionDownloadDelegate` protocol.

This class was originally designed for iOS 4, so with some simple modifications it could be backwards compatible as well.


Usage
-----

Use either of the designated initalizers, depending on how you'd like to receive completion notices:

###Blocks based:

		JBContainedURLConnection *connection = [[JBContainedURLConnection alloc] initWithURLString:someURLString userInfo:contextDictionary completionHandler:^(JBContainedURLConnection *connection, NSError *error, NSString *urlString, NSDictionary *userInfo, NSData *data) {
			
			if (nil != error) {
				
				// Handle the error.
				// A nil error indicates success!
				
				NSLog(@"Error! %@", [error userInfo]);
				return;
			}
			
			// Loading succeeded. Use the data, and optionally the URL and userInfo to determine context.
			NSLog(@"All done loading");
		}];
		
A non-nil error implies a failure. If the error is nil, then the loading was successful.


###Delegate based:

Initialize with `- (id)initWithURLString:(NSString *)urlString userInfo:(NSDictionary *)userInfo delegate:(id<JBContainedURLConnectionDelegate>)delegate;` and implement the two `JBContainedURLConnectionDelegate` methods (both required)


**Note**: With either of these approaches, the `data` property is not guaranteed to exist after the callback method or Block is executed. If you want this data to stick around, it's your job to take ownership of it.


License
-------

This class and the example project are released in the Public Domain. Do whatever you wish with them. If you enhance the class, a pull request would be lovely but is by no means required.