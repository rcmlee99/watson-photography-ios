//
//  WPMainViewController.m
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "WPMainViewController.h"
#import "WPWatson.h"
#import "WPResultsTableViewController.h"
#import "WPUtils.h"

@implementation WPMainViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) askWatsonButtonClicked:(id)sender
{
    //Hide the keyboard
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Check for the right segue
    if ([segue.identifier isEqualToString:SEGUE_SHOW_ANSWER_LIST]) {

        //Build a loading animation
        UIActivityIndicatorView *spinner = [WPUtils buildBusyIndicator];
        
        //Get the table view controller that will have the answers
        WPResultsTableViewController *tableViewController = segue.destinationViewController;
        
        //Add the loading animation and start it
        [tableViewController.view addSubview:spinner];
        [spinner startAnimating];
        
        //Get the question from the UI
        NSString* question = self.questionTextField.text;

        //Send an asynchronous network request to the watson API
        [[WPWatson sharedManager] askQuestion:question completionHandler:^(NSError *connectionError) {
                        
            //Reload the table to show the data from the response, must be done on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [tableViewController.tableView reloadData];
                
                //Stop the loading animation
                [spinner stopAnimating];
            });
        }];

    }
}

@end
