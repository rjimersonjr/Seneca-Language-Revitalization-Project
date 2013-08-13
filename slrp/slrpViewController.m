//
//  slrpViewController.m
//  slrp
//
//  Created by Robert Jimerson Jr on 8/6/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import "slrpViewController.h"
#import "JSONutils.h"

@interface slrpViewController ()

@end

@implementation slrpViewController

@synthesize eWord;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    eWord = [[senecaWord alloc] init];
    self.eWordEntered.delegate = self;
    printf("The slrpViewController just loaded!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)nextButtonPressed:(id)sender{
    NSLog(@"The next button was pressed!");
    NSString *englishWordEntered = _eWordEntered.text;
    if ([englishWordEntered isEqualToString:@""]) {
        UIAlertView* alert;
        alert = [[UIAlertView alloc] initWithTitle:@"You didn't enter a Seneca Word" message:@"You must enter a Seneca Word to continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        //[alert release];
    }
    else{
        JSONutils *jsonS = [[JSONutils alloc] init];
        NSLog(@"English Word entered is: %@", englishWordEntered );
        [jsonS Get_Matches:englishWordEntered];
        //Function to grab the JSON word.
    
    }
}

-(IBAction)resetButtonPressed:(id)sender{
    NSLog(@"The reset button was hit!");
}

-(IBAction)dismissKeyboard{
    NSLog(@"We are in the dismissKeyboard action!");
    [_eWordEntered resignFirstResponder];
}

@end
