//
//  WPRequest.m
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "WPWatson.h"
#import "WPUtils.h"

@implementation WPWatson

//This class is a singleton
+(instancetype) sharedManager
{
    //Keep the instance of the singleton in sharedManager
    static WPWatson *sharedManager = nil;
    
    //Call the code below only a single time to initialize the singleton instance
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        
        //Set current question and responses as empty string and dictionary respectively
        sharedManager.currentQuestion = @"";
        sharedManager.responses = [[NSMutableDictionary alloc] init];
        
        //Queue used for the asynchornous network requests
        sharedManager.queue = [[NSOperationQueue alloc] init];
    });
    
    return sharedManager;
}

-(void) askQuestion:(NSString*) question completionHandler:(void (^)(NSError* connectionError)) callback
{
    //Save the question, we reference this in our controllers
    self.currentQuestion = question;
    
    //Clear cache if more than 3 questions have been cached
    if ([self.responses count] > MAX_NUM_QUESTION_CACHED) {
        self.responses = [[NSMutableDictionary alloc] init];
    }
    
    //Check if the question if not in the cache
    if (! self.responses[question]) {
        
        //Read config.plist
        NSString *path = [[NSBundle mainBundle] pathForResource:CONFIG_PLIST_FILE_NAME ofType:CONFIG_PLIST_EXTENSION];
        NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        //Get the user and password from config.plist
        NSString* user = config[KEY_CONFIG_PLIST_USER];
        NSString* pwd = config[KEY_CONFIG_PLIST_PASSWORD];
        
        //When no user or password is found, use fake data
        if (![user length] || ![pwd length]) {
        
            NSLog(@"No user or password found in the config file, using fake data.");
            
            //Read data from fake.json
            NSString *filePath = [[NSBundle mainBundle] pathForResource:FAKE_FILE_NAME ofType:FAKE_FILE_EXTENSION];
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            
            //Extract the useful bits (answers, evidence and the question text)
            WPWatsonQuestionResponse* res = [WPUtils buildResponseObjectWithData:data];
            
            //Save it so we can reference it in our controllers
            [self.responses setObject:res forKey:question];

            //Inform the caller we are done, nil means no error
            callback(nil);
        
        } else {
            
            //Pepare the url and request to contact the server
            NSURL* url = [NSURL URLWithString:URL_WATSON_ASK_QUESTION];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod: @"POST"];
            [request setValue:@"30" forHTTPHeaderField:@"X-SyncTimeout"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
            
            //The server uses basic auth, the format is: 'Basic base64(user:pass)'
            NSString* authHeader = [WPUtils getBase64AuthHeaderWithUsername:user andPassword:pwd];
            [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
            
            //Add the question to the post body
            NSString *postString = [NSString stringWithFormat:WATSON_ASK_QUESTION_PAYLOAD_TEMPLATE, question];
            [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
            
            //Send the network request
            [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                 
                 if (error) {
                 
                     NSLog(@"Error contacting the server: %@", error);
                 
                 } else {
                     
                     //Extract the useful bits (answers, evidence and the question text)
                     WPWatsonQuestionResponse* res = [WPUtils buildResponseObjectWithData:data];

                     //Save it so we can reference it in our views
                     [self.responses setObject:res forKey:question];
                 }
                
                //Inform the caller we are done
                callback(error);
             }];
        }

    } else {
        
        //Getting here means the question is already cached
        
        //Inform the caller we are done, nil means no error
        callback(nil);
    }
}

@end
