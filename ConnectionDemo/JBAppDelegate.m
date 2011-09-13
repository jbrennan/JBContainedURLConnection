//
//  JBAppDelegate.m
//  ConnectionDemo
//
//  Created by Jason Brennan on 11-09-13.
//  Public Domain
//

#import "JBAppDelegate.h"
#import "JBViewController.h"


@implementation JBAppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
	// Override point for customization after application launch.
	self.viewController = [[JBViewController alloc] initWithNibName:@"JBViewController" bundle:nil]; 
	
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
	return YES;
}



@end
