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
    //self.lblEnglish = [[UILabel alloc] initWithFrame:CGRectMake(218, 332, 200, 50)];
    //self.lblEnglish.text = @"English Input:";
    //[self.view addSubview:self.lblEnglish];
    
    self.lblEnglish_input = [[UILabel alloc] initWithFrame:CGRectMake(337, 317, 200, 50)];
    self.lblEnglish_input.text = seneca_word.english_input;
    [self.view addSubview:self.lblEnglish_input];
    NSLog(@"We are in the drop down menus! %@", seneca_word.english_input);
    
    array_when_choices = [[NSMutableArray alloc] init];
    [array_when_choices addObject:@"-Select-"];
    [array_when_choices addObject:@"did it"];
    [array_when_choices addObject:@"will do it"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //We only have one column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    //This will be changed to the count of your array
    //return [arrayTimes count];
    return [array_when_choices count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    //NSLog(@"data for row #%d = %@", row, [arrayDates objectAtIndex:row]);
    return [array_when_choices objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    //label.font = [UIFont fontWithName:@"the_hungry_ghost" size:16.0];
    //NSString *picked = [arrayDates objectAtIndex:row];
    //NSLog(@"About to be stored in the teTime property: %@", picked);
    //self.teTime.date = [arrayDates objectAtIndex:row];
    seneca_word.when = [array_when_choices objectAtIndex:row];
    NSLog(@"The row picked is: %@", seneca_word.when);
    //label.font = [UIFont fontWithName:[data objectAtIndex:row] size:16.0];
}

@end
