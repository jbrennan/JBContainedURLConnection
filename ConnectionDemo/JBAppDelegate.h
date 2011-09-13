//
//  JBAppDelegate.h
//  ConnectionDemo
//
//  Created by Jason Brennan on 11-09-13.
//  Public Domain
//

#import <UIKit/UIKit.h>

@class JBViewController;

@interface JBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JBViewController *viewController;

@end
