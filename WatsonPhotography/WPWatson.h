//
//  WPRequest.h
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPWatsonQuestionResponse.h"

@interface WPWatson : NSObject

@property (nonatomic, retain) NSMutableDictionary* responses;
@property (nonatomic, retain) NSString* currentQuestion;
@property (nonatomic, retain) NSOperationQueue* queue;

+(instancetype) sharedManager;

-(void) askQuestion:(NSString*) question completionHandler:(void (^)(NSError* connectionError)) block;

@end
