//
//  slrpViewController.m
//  slrp
//
//  Created by Robert Jimerson Jr on 8/6/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import "slrpViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "JSONutils.h"

@interface slrpViewController ()

@end


@implementation slrpViewController

@synthesize seneca_word, whenPicker, whoPicker, dataArray;
@synthesize spinner;
@synthesize responseData;
@synthesize getMatchesDict;
@synthesize directionSelected;
@synthesize directionalPicker;
@synthesize nextDirectionalButton;
@synthesize auto_complete_array;
@synthesize autocompleteTableView;
@synthesize pastUrls;
@synthesize autocompleteUrls;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dataArray = [[NSMutableArray alloc] init];
    pastUrls = [[NSMutableArray alloc] init];
    
    [self getAutoCompleteArray];
    seneca_word = [[senecaWord alloc] init];
    //Dirty way to initialize to non-null
    seneca_word.who = @"";
    seneca_word.done_to = @"";
    seneca_word.direction = @"";
    seneca_word.english_input = @"";
    
    //self.pastUrls = [[NSMutableArray alloc] initWithObjects:@"www.google.com", nil];
    //self.pastUrls = dataArray;
    NSLog(@"In the viewDidLoad and pasturl is: %@", pastUrls);
    self.autocompleteUrls = [[NSMutableArray alloc] init];
    
    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(210, 225, 310, 120) style:UITableViewStylePlain];
    //275,210,312,120
    self.autocompleteTableView.delegate = self;
    //[autocompleteTableView setDelegate:self];
    self.autocompleteTableView.dataSource = self;
    //self.autocompleteTableView.layer.borderWidth = 1.0;
    CALayer *layer = self.autocompleteTableView.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius: 4.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithWhite: 0.8 alpha: 1.0] CGColor]];
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    [self.view addSubview:autocompleteTableView];
    //Creating the when label that will be show after the word is successfully entered
    //self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 353, 200, 50)];
    //self.nameLabel.textAlignment = NSTextAlignmentCenter;
    //self.nameLabel.text = @"When?";
    //[self.view addSubview:self.nameLabel];
    //self.nameLabel.hidden = YES;
    
    //[self.view addSubview:self.choicePicker];
    
    //self.choicePicker.delegate = self;
    //[self.choicePicker setHidden:NO];
    //self.choicePicker.hidden = NO;
    //Create the UIPickerView
    
    //dataArray = [[NSMutableArray alloc] init];
    //[self getAutoCompleteArray];
    
    
    // Add some data for demo purposes.
    //[dataArray addObject:@"One"];
    //[dataArray addObject:@"Two"];
    //[dataArray addObject:@"Three"];
    //[dataArray addObject:@"Four"];
    //[dataArray addObject:@"Five"];
    
    //self.whenPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(315, 300, 225, 100)];
    //[self.whenPicker setDataSource: self];
    //[self.whenPicker setDelegate: self];
    
    //self.whenPicker.showsSelectionIndicator = YES;
    //[self.whenPicker selectRow:2 inComponent:0 animated:YES];
    //[self.view addSubview:self.whenPicker];
    //self.whenPicker.hidden = YES;
    
    
    //self.eWordEntered.delegate = self;
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
        self.seneca_word.english_word = englishWordEntered;
        
        NSLog(@"Entered into seneca_word object: %@", seneca_word.english_word);
        
        //[jsonS Get_Matches:englishWordEntered];
        [self Get_Matches:englishWordEntered];

        //NSDictionary *getMatchesDict = jsonS.getMatchesDict;
        //NSLog(@"The getGetMatchesDict is: %@", jsonS.getMatchesDict);
        NSLog(@"The getGetMatchesDict is: %@", self.getMatchesDict);
        
        //Function to grab the JSON word.
        //Move to next segue
        //UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.spinner.center = CGPointMake(300, 400);
        self.spinner.tag = 12;
        [self.view addSubview:spinner];
        [self.spinner startAnimating];
    }
}

-(IBAction)resetButtonPressed:(id)sender{
    NSLog(@"The reset button was hit!");
}

-(IBAction)dismissKeyboard:(id)sender{
    NSLog(@"We are in the dismissKeyboard action!");
    [self.view endEditing:YES]; 
    [_eWordEntered resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //NSString *englishInput = [[dataArray objectAtIndex: row] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *englishInput = [dataArray objectAtIndex: row];
    self.seneca_word.english_input = englishInput;
    //NSLog(@"The class variable self.seneca_word_input is: %@", self.seneca_word.english_input);
    
    NSLog(@"The original selected is: %@", [dataArray objectAtIndex: row]);
    if([[dataArray objectAtIndex: row] rangeOfString:@"this"].location != NSNotFound){
        seneca_word.direction = @"toward";
        NSLog(@"It's a cislocative the direction is: %@", seneca_word.direction);
    }
    else if([[dataArray objectAtIndex: row] rangeOfString:@"that"].location != NSNotFound){
        
        seneca_word.direction = @"away";
        NSLog(@"It's a translocative the direction is: %@", seneca_word.direction);
    }
    else{
        seneca_word.direction = @"";
        NSLog(@"No direction");
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    //NSLog(@"The first element is: %@", [dataArray objectAtIndex:0]);
    return [dataArray objectAtIndex: row];
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
    seneca_word.ids = [jsonDict objectForKey:@"ids"];
    NSArray *array_ids = [jsonDict objectForKey:@"ids"];
    NSString *ids = array_ids[0];
    seneca_word.ids = ids;
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
        NSUInteger keyCount = [[jsonDict objectForKey:@"bases"] count];
        NSArray *base_props = [jsonDict objectForKey:@"base_props"];
        //NSArray *english_bases = [jsonDict objectForKey:@"base_props"];
        //Have to check to see if it's the autocomplete stuff
        if([jsonDict objectForKey:@"english_bases"] != nil){
            //auto_complete_array = [jsonDict objectForKey:@"english_bases"];
            pastUrls = [jsonDict objectForKey:@"english_bases"];
            NSLog(@"We are in the autocomplete part of the loop! %@", pastUrls);
        }
        else if ([base_props containsObject:@"trans"] || [base_props containsObject:@"cis"]) {
            NSLog(@"It is a cis or transloc");
            [self buildDirectionalMenu:jsonDict];
        }
        else{
            NSLog(@"It's a 'regular' word");
        //}
        //if(keyCount > 1){
        //    NSLog(@"More than one key returned!");
        //    [self buildDirectionalMenu:jsonDict];
        //}
        //else{
            getMatchesDict = jsonDict;
            NSLog(@"In the class method slrpViewController!");
            [spinner stopAnimating];
            [self performSegueWithIdentifier:@"segue_drop_downVC" sender:self];
            NSLog(@"The size of the choices: %d", keyCount);
            //NSLog(@"The jsonArray is: %@", jsonArray);
            for(NSDictionary *item in jsonArray)
            {
                NSLog(@"Item: %@", item);
            }//for(NSDict..)
        }//else(keyCount > 1)
        
    }//else
    
    
}//(void)connectionDidFinishLoading
-(void)buildDirectionalMenu:(NSDictionary *)choiceDict{
    //in this method we build the choices menu
    
    NSLog(@"We are in the buildDirectionalMenu");
    //NSLog(@"buildChoiceMenu method the jsonDict is: %@", choiceDict);
    NSArray *base_props = [choiceDict objectForKey:@"base_props"];
    NSArray *base_array = [choiceDict valueForKey:@"bases"];
    NSString *base_word = base_array[0];
    NSLog(@"In buildDirectionalMenu the base_word is: %@", base_word);
    if ([base_props containsObject:@"trans"])
    {
        NSString *trans_phrase = [NSString stringWithFormat:@"%@ that way", base_word];
        [dataArray addObject:trans_phrase];
    }
    if ([base_props containsObject:@"cis"])
    {
        NSString *cis_phrase = [NSString stringWithFormat:@"%@ this way", base_word];
        [dataArray addObject:cis_phrase];
    }
    NSString *just_base_word = [NSString stringWithFormat:@"no direction just %@", base_word];
    [dataArray addObject:just_base_word];
    //NSString *firstElementOfDataArray = [dataArray[0] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    //self.seneca_word.english_input = firstElementOfDataArray;
    //NSLog(@"After we cleaned it up: %@", firstElementOfDataArray);
    
    if([[dataArray objectAtIndex: 0] rangeOfString:@"this"].location != NSNotFound){
        seneca_word.direction = @"toward";
        NSLog(@"It's a cislocative, direction is: %@", seneca_word.direction);
    }
    else if([[dataArray objectAtIndex: 0] rangeOfString:@"that"].location != NSNotFound){
        
        seneca_word.direction = @"away";
        NSLog(@"It's a translocative, direction is: %@", seneca_word.direction);
    }
    else{
        seneca_word.direction = @"";
        NSLog(@"No direction");
    }
    
    [self.directionalPicker selectRow:0 inComponent:0 animated:YES];
    [self.nextDirectionalButton setHidden:NO];
    [self.directionalPicker reloadAllComponents];
    [self.directionalPicker setHidden:NO];
    
    [spinner stopAnimating];
}
-(IBAction)directionalButtonPressed:(id)sender{
    NSLog(@"We are in the nextDirectionPressed and the english input is: %@", self.seneca_word.english_input);
    //NSInteger *row = [choicePicker selectedRowInComponent:0];
    //NSString *choiceSelected = [dataArray objectAtIndex:row];
    //NSLog(@"the selected choice is: %@", choiceSelected);
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(500, 600);
    self.spinner.tag = 12;
    [self.view addSubview:spinner];
    [self.spinner startAnimating];
    [self performSegueWithIdentifier:@"segue_drop_downVC" sender:self];
    //[self Get_Matches:self.seneca_word.english_input];
}
-(void) getAutoCompleteArray{
    //NSArray *autoCompleteArray;
    
    NSLog(@"In the getAutoComplete Array method");
    NSString *urlGetAutoCompleteString = [NSString stringWithFormat:@"http://senecadictionary.com/autocomplete?e="];
    NSLog(@"The urlGetMatchesString is: %@", urlGetAutoCompleteString);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlGetAutoCompleteString]];
    
    //NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
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


    
    //return autoCompleteArray;
}
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteUrls removeAllObjects];
    for(NSString *curString in pastUrls) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [autocompleteUrls addObject:curString];
        }
    }
    [autocompleteTableView reloadData];
}
#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompleteUrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    //if (cell == nil) {
    //    cell = [[[UITableViewCell alloc]
    //             initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier] autorelease];
    //}
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    cell.textLabel.text = [autocompleteUrls objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.eWordEntered.text = selectedCell.textLabel.text;
    
    //[self goPressed];
    if(tableView == autocompleteTableView){
        //The autocomplete table view is the one that fired the didSelect delegate method
        //So hide the autocomplete table.
        //do whatever else you need to do to empty the autocompleteTableView's data source
        //or/and simply hide the table after that
        [autocompleteTableView setHidden:YES];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TOUCHED"); // never happens
    //for (UITouch *touch in touches) {
    [autocompleteTableView setHidden:YES];
    //}
}

@end
