//
//  JBViewController.m
//  ConnectionDemo
//
//  Created by Jason Brennan on 11-09-13.
//  Public Domain
//

#import "JBViewController.h"
#import "JBContainedURLConnection.h"


@implementation JBViewController
@synthesize connection = _connection;


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark View life cycle


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	// Create a connection, loading a large image file
    NSURL *largeURL = [NSURL URLWithString:@"http://apod.nasa.gov/apod/image/0901/newrings_cassini_big.jpg"];
	_connection = [[JBContainedURLConnection alloc] initWithURL:largeURL userInfo:nil completionHandler:^(JBContainedURLConnection *connection, NSError *error, NSURL *url, NSDictionary *userInfo, NSData *data) {
		
		if (nil != error) {
			
			// Handle the error.
			// A nil error indicates success!
			
			NSLog(@"Error! %@", [error userInfo]);
			return;
		}
		
		// Loading succeeded. Use the data, and optionally the URL and userInfo to determine context.
		NSLog(@"All done loading");
	}];
}


- (IBAction)present:(id)sender {
	NSLog(@"Presenting a view controller!");
	JBViewController *v = [[JBViewController alloc] initWithNibName:@"JBViewController" bundle:nil];
	[self presentModalViewController:v animated:YES];
	
}


- (IBAction)done:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}



@end
