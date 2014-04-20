//
//  WPResultsDetailsViewController.m
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "WPResultsDetailsViewController.h"
#import "WPUtils.h"
#import "WPWatsonQuestionResponse.h"

@implementation WPResultsDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Get the current response
    WPWatson* watson = [WPWatson sharedManager];
    WPWatsonQuestionResponse* response = watson.responses[watson.currentQuestion];
    
    //Get the current answer
    NSDictionary* currentAnswer = response.answers[self.row];
    
    //Set labels for text and confidence based on the current answer
    self.confidenceLabel.text = [NSString stringWithFormat:@"%@", currentAnswer[KEY_CONFIDENCE]];
    self.answerTextBox.text = currentAnswer[KEY_TEXT];
    
    //Get a random number and use it to populate the UI with a random evidence
    int randNum = [WPUtils randomNumberWithMax:response.evidence.count-1 andMin:0];
    self.evidenceTextBox.text = response.evidence[randNum][KEY_TEXT];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
