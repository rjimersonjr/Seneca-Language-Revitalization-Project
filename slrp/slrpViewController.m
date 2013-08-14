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
    
    //Creating the when label that will be show after the word is successfully entered
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 353, 200, 50)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.text = @"When?";
    [self.view addSubview:self.nameLabel];
    self.nameLabel.hidden = YES;
    
    //Create the UIPickerView
    dataArray = [[NSMutableArray alloc] init];
    
    // Add some data for demo purposes.
    [dataArray addObject:@"One"];
    [dataArray addObject:@"Two"];
    [dataArray addObject:@"Three"];
    [dataArray addObject:@"Four"];
    [dataArray addObject:@"Five"];
    
    self.whenPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(315, 300, 225, 100)];
    [self.whenPicker setDataSource: self];
    [self.whenPicker setDelegate: self];
    
    self.whenPicker.showsSelectionIndicator = YES;
    [self.whenPicker selectRow:2 inComponent:0 animated:YES];
    [self.view addSubview:self.whenPicker];
    self.whenPicker.hidden = YES;
    
    
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


//++++++++++++++++++++++++++++++++++++++++++PickerView Stuff++++++++++++++++++++++++++++++++++++++++++++++++++++
// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

// Display each row's data.
-(NSString *)whenPicker:(UIPickerView *)whenPicker titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [dataArray objectAtIndex: row];
}

// Do something with the selected row.
-(void)whenPicker:(UIPickerView *)whenPicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"You selected this: %@", [dataArray objectAtIndex: row]);
}



@end
