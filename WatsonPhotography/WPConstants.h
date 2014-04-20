//
//  WPConstants.h
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPConstants : NSObject

extern NSString* const MY_IDENTIFIER;

extern NSString * const SEGUE_SHOW_ANSWER_LIST;
extern NSString * const SEGUE_SHOW_RESULTS_DETAILS;

extern NSString * const KEY_TEXT;
extern NSString * const KEY_CONFIDENCE;

extern NSString * const FAKE_FILE_NAME;
extern NSString * const FAKE_FILE_EXTENSION;

extern NSString * const PATH_TO_ANSWERS;
extern NSString * const PATH_TO_EVIDENCE;

extern NSString * const URL_WATSON_ASK_QUESTION;
extern NSString * const WATSON_ASK_QUESTION_PAYLOAD_TEMPLATE;

extern NSString * const KEY_CONFIG_PLIST_USER;
extern NSString * const KEY_CONFIG_PLIST_PASSWORD;

extern NSString * const CONFIG_PLIST_FILE_NAME;
extern NSString * const CONFIG_PLIST_EXTENSION;

extern NSUInteger const MAX_NUM_QUESTION_CACHED;

@end
