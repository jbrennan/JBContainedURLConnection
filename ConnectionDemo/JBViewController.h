//
//  JBViewController.h
//  ConnectionDemo
//
//  Created by Jason Brennan on 11-09-13.
//  Public Domain
//

#import <UIKit/UIKit.h>


@class JBContainedURLConnection;
@interface JBViewController : UIViewController

@property (nonatomic, strong) JBContainedURLConnection *connection;


- (IBAction)present:(id)sender;
- (IBAction)done:(id)sender;


@end
