//
//  outputViewController.m
//  slrp
//
//  Created by Robert Jimerson Jr on 12/4/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import "outputViewController.h"

@interface outputViewController ()

@end

@implementation outputViewController

@synthesize seneca_word;
@synthesize lblSeneca_output;
@synthesize lblEnglish_ouput;

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
    NSLog(@"In the output VC and the seneca_word object is: %@", seneca_word.seneca);
    NSLog(@"The english word is: %@", seneca_word.english_output);
    self.lblSeneca_output = [[UILabel alloc] initWithFrame:CGRectMake(365, 80, 200, 50)];
    self.lblSeneca_output.text = seneca_word.seneca;
    self.lblSeneca_output.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    [self.view addSubview:self.lblSeneca_output];
    
    
    
    self.lblEnglish_ouput = [[UILabel alloc] initWithFrame:CGRectMake(500, 80, 200, 50)];
    self.lblEnglish_ouput.text = seneca_word.english_output;
    [self.view addSubview:self.lblEnglish_ouput];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
