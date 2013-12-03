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
@synthesize responseData;
@synthesize getMatchesDict;
@synthesize isFinished;

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
        //JSONutils *jsonS = [[JSONutils alloc] init];
        NSLog(@"English Word entered is: %@", englishWordEntered );
        self.seneca_word.english_input = englishWordEntered;
        
        NSLog(@"Entered into seneca_word object: %@", seneca_word.english_input);
        
        //[jsonS Get_Matches:englishWordEntered];
        [self Get_Matches:englishWordEntered];

        //NSDictionary *getMatchesDict = jsonS.getMatchesDict;
        //NSLog(@"The getGetMatchesDict is: %@", jsonS.getMatchesDict);
        NSLog(@"The getGetMatchesDict is: %@", self.getMatchesDict);
        
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

-(void)Get_Matches:(NSString*)englishWord{
    
    isFinished = FALSE;
    NSLog(@"In the Get_Matches method");
    NSString *urlGetMatchesString = [NSString stringWithFormat:@"http://senecadictionary.com/matches?e=%@", englishWord];
    NSLog(@"The urlGetMatchesString is: %@", urlGetMatchesString);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlGetMatchesString]];
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    if (urlConnection) {
        //NSMutableData *jsonReceivedData;
        // Create the NSMutableData that will hold
        // the received data
        // receivedData is declared as a method instance elsewhere
        
        receivedData =[NSMutableData data];
        NSLog(@"We have a good connection, now what?  Here is the data received %@", receivedData);
        
    } else {
        // inform the user that the download could not be made
        UIAlertView* alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Network Issues" message:@"Unable to get the data from the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
}



-(void)setReceivedData:(NSMutableData*)pReceivedData
{
    receivedData = pReceivedData;
    //[receivedData appendData:data];
}

-(NSMutableData *) getReceivedData{
    return receivedData;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // It can be called multiple times, for example in the case of a
    
    // redirect, so each time we reset the data.
    
    
    
    // receivedData is an instance variable declared elsewhere.
    NSLog(@"We are in the didReceiveResponse");
    [receivedData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    // Append the new data to receivedData.
    
    // receivedData is an instance variable declared elsewhere.
    NSLog(@"We are in the didReceiveData and appending data");
    [receivedData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // inform the user
    
    NSLog(@"Connection failed! Error - %@ %@",
          
          [error localizedDescription],
          
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    
    //NSLog(@"The receivedData is: %@", receivedData);
    
    NSError *e = nil;
    NSError *error = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: receivedData options: NSJSONReadingMutableContainers error: &e];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:receivedData
                                                             options:kNilOptions
                                                               error:&error];
    //NSLog(@"JSON: %@", jsonDict);
    //NSString *bases = [jsonDict objectForKey:@"bases"];
    //NSString *ids = [jsonDict objectForKey:@"ids"];
    //NSLog(@"The bases returned is: %@ and the ids are: %@", bases, ids);
    
    for (id key in jsonDict)
    {
        NSLog(@"key: %@, value: %@", key, [jsonDict objectForKey:key]);
        NSLog(@"The value of bases by itself is: %@", [jsonDict objectForKey:@"bases"]);
    }
    
    if (!jsonArray)
    {
        NSLog(@"Error parsing JSON: %@", e);
    }
    else
    {
        //NSLog(@"The jsonArray is: %@", jsonArray);
        for(NSDictionary *item in jsonArray)
        {
            NSLog(@"Item: %@", item);
        }//for(NSDict..)
    }//else
    getMatchesDict = jsonDict;
    NSLog(@"In the class method slrpViewController!");
    [self performSegueWithIdentifier:@"segue_drop_downVC" sender:self];
}//(void)connectionDidFinishLoading


@end
