//
//  WPUtils.m
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "WPUtils.h"

@implementation WPUtils

+(void) styleNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x0629dc1)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    
    NSDictionary* textAttr = @{NSForegroundColorAttributeName : [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],
                               NSShadowAttributeName: shadow,
                               NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:19.0]};
    
    [[UINavigationBar appearance] setTitleTextAttributes: textAttr];
}

+(UIActivityIndicatorView*) buildBusyIndicator
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [spinner setColor:[UIColor blackColor]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    spinner.center = CGPointMake(screenWidth/2, screenHeight/2);
    
    return spinner;
}

+(int) randomNumberWithMax:(int) max andMin:(int) min
{    
    int randNum = rand() % (max - min) + min;
    
    return randNum;
}

+(WPWatsonQuestionResponse*) buildResponseObjectWithData:(NSData*) data
{
    NSArray *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                            options:kNilOptions
                                                              error:nil];
    
    WPWatsonQuestionResponse* res = [[WPWatsonQuestionResponse alloc] init];
    res.answers = [jsonResponse valueForKeyPath:PATH_TO_ANSWERS];
    res.evidence = [jsonResponse valueForKeyPath:PATH_TO_EVIDENCE];
    
    return res;
}

+(NSString*) getBase64AuthHeaderWithUsername:(NSString*) user andPassword:(NSString*) password
{
    NSString* base64Login = [NSString stringWithFormat:@"%@:%@", user, password];
    
    NSData *plainDataLogin = [base64Login dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64StringLogin = [NSString stringWithFormat:@"Basic %@", [plainDataLogin base64EncodedStringWithOptions:kNilOptions]];
    
    return base64StringLogin;
}


@end
