//
//  WPMainViewController.h
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *questionTextField;

-(IBAction) askWatsonButtonClicked:(id)sender;

@end
