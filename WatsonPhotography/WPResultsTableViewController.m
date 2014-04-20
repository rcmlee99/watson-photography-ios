//
//  WPResultsTableViewController.m
//  WatsonPhotography
//
//  Created by Carlos Andreu on 4/19/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "WPResultsTableViewController.h"
#import "WPResultsDetailsViewController.h"
#import "WPUtils.h"

@implementation WPResultsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    WPWatson* watson = [WPWatson sharedManager];
    WPWatsonQuestionResponse* response = watson.responses[watson.currentQuestion];
    return response.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WPWatson* watson = [WPWatson sharedManager];
    
    //Get a cell if possible
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MY_IDENTIFIER];
    
    //Cell not found
    if (cell == nil) {
        
        //Create new cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MY_IDENTIFIER];
        
        //Set properties on the cell
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        cell.textLabel.numberOfLines = 4;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //Set the text on the cell
    WPWatsonQuestionResponse* res = watson.responses[watson.currentQuestion];
    cell.textLabel.text = res.answers[indexPath.row][KEY_TEXT];
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Check if it is the right segue
    if ([segue.identifier isEqualToString:SEGUE_SHOW_RESULTS_DETAILS]) {
        
        //Access the detail view controller
        WPResultsDetailsViewController *detailViewController = segue.destinationViewController;
        
        //Save the row number and send it to the detail view controller
        long row = [[self.tableView indexPathForSelectedRow] row];
        detailViewController.row = row;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Swicth to the answers details page when a row is clicked
    [self performSegueWithIdentifier:SEGUE_SHOW_RESULTS_DETAILS sender:self];
}

@end
