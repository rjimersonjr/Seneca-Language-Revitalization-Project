//
//  dropDownMenuViewController.m
//  slrp
//
//  Created by Robert Jimerson Jr on 8/12/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import "dropDownMenuViewController.h"

@interface dropDownMenuViewController ()

@end

@implementation dropDownMenuViewController

@synthesize seneca_word;

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
    NSLog(@"We are in the drop down menus! %@", seneca_word.english_input);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
