//
//  WPResultsDetailsViewController.h
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPWatsonQuestionResponse.h"
#import "WPWatson.h"

@interface WPResultsDetailsViewController : UIViewController

@property (nonatomic) int row;

@property (weak, nonatomic) IBOutlet UILabel *confidenceLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextBox;
@property (weak, nonatomic) IBOutlet UITextView *evidenceTextBox;

@end
