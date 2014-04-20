//
//  WPUtils.h
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPWatsonQuestionResponse.h"

@interface WPUtils : NSObject

+(void) styleNavigationBar;

+(UIActivityIndicatorView*) buildBusyIndicator;

+(int) randomNumberWithMax:(int) max andMin:(int) min;

+(WPWatsonQuestionResponse*) buildResponseObjectWithData:(NSData*) data;

+(NSString*) getBase64AuthHeaderWithUsername:(NSString*)user andPassword:(NSString*) password;

@end
