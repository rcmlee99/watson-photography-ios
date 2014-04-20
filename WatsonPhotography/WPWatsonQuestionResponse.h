//
//  WPWatsonQuestionResponse.h
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPWatsonQuestionResponse : NSObject

@property (nonatomic, strong) NSArray* answers;
@property (nonatomic, strong) NSArray* evidence;

@end
