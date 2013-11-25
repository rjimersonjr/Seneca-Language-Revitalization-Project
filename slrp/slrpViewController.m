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

@synthesize seneca_word, whenPicker, whoPicker, dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    seneca_word = [[senecaWord alloc] init];
    
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
        self.seneca_word.english_input = englishWordEntered;
        
        NSLog(@"Entered into seneca_word object: %@", seneca_word.english_input);
        
        [jsonS Get_Matches:englishWordEntered];

        //NSDictionary *getMatchesDict = jsonS.getMatchesDict;
        NSLog(@"The getGetMatchesDict is: %@", jsonS.getMatchesDict);
        
        //Function to grab the JSON word.
        //Move to next segue
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //NSLog(@"The segue identifier is: %@", [segue identifier]);
    //if ([[segue identifier] isEqualToString:@"YOUR_SEGUE_NAME_HERE"])
    
    //Creating an object for the next VC so we can send the seneca_word object to it
    dropDownMenuViewController *nextViewController = [segue destinationViewController];
    
    //Passing the seneca_word object to the next VC
    nextViewController.seneca_word = self.seneca_word;
    
}



@end
