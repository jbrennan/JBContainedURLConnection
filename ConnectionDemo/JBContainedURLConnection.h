//
//  JBContainedURLConnection.h
//  
//
//  Created by Jason Brennan on 11-06-19.
//  Public Domain
//

#import <Foundation/Foundation.h>


@class JBContainedURLConnection;

// The completion callback type. A nil error indicates success.
// Your callback should check to see if error is non-nil, and react accordingly.
// urlString and userInfo are used for context in the callback.
typedef void (^JBContainedURLConnectionCompletionHandler)(JBContainedURLConnection *connection, NSError *error, NSString *urlString, NSDictionary *userInfo, NSData *data);


// Alternatively, a delegate mechanism is available
@protocol JBContainedURLConnectionDelegate <NSObject>

- (void)HTTPConnection:(JBContainedURLConnection *)connection didFailWithError:(NSError *)error;
- (void)HTTPConnection:(JBContainedURLConnection *)connection didCompleteForURL:(NSString *)urlString userInfo:(NSDictionary *)userInfo completedData:(NSData *)data;

@end



@interface JBContainedURLConnection : NSObject


@property (nonatomic, weak, readonly) id<JBContainedURLConnectionDelegate> delegate;
@property (nonatomic, copy, readonly) JBContainedURLConnectionCompletionHandler completionHandler;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) NSDictionary *userInfo;


// Initializers.
// Pass in a URL of the requested resource. The userInfo dictionary is to pass along any context you'd like passed back to you upon completion or error.
- (id)initWithURLString:(NSString *)urlString userInfo:(NSDictionary *)userInfo delegate:(id<JBContainedURLConnectionDelegate>)delegate;
- (id)initWithURLString:(NSString *)urlString userInfo:(NSDictionary *)userInfo completionHandler:(JBContainedURLConnectionCompletionHandler)handler;


// Cancels the connection.
- (void)cancel;


@end
