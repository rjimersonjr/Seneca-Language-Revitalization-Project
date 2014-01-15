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
@synthesize spinner;
@synthesize responseData;
@synthesize getMatchesDict;
@synthesize lblEnglish_input;
@synthesize lblEnglish;

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
    
    self.lblEnglish_input = [[UILabel alloc] initWithFrame:CGRectMake(365, 80, 200, 50)];
    self.lblEnglish_input.text = seneca_word.english_input;
    [self.view addSubview:self.lblEnglish_input];
    
    seneca_word.english_input = [seneca_word.english_input stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    //NSRange result = [seneca_word.english_input rangeOfString:@"this"];
    if([seneca_word.english_input rangeOfString:@"this"].location != NSNotFound){
      seneca_word.direction = @"toward";
        NSLog(@"It's a translocative");
    }
    else if([seneca_word.english_input rangeOfString:@"that"].location != NSNotFound){
        seneca_word.direction = @"away";
        NSLog(@"It's a cislocative");
    }
    else{
        seneca_word.direction = @"";
        NSLog(@"No direction");
    }
    
    NSLog(@"We are in the drop down menus! %@", seneca_word.english_input);
    
    array_when_choices = [[NSMutableArray alloc] init];
    [array_when_choices addObject:@"-Select-"];
    [array_when_choices addObject:@"did it"];
    [array_when_choices addObject:@"will do it"];
    [array_when_choices addObject:@"might do it"];
    [array_when_choices addObject:@"does it"];
    [array_when_choices addObject:@"is doing it"];
    [array_when_choices addObject:@"has done it"];
    [array_when_choices addObject:@"do it!"];
    
    array_who_choices = [[NSMutableArray alloc] init];
    [array_who_choices addObject:@"-Select-"];
    [array_who_choices addObject:@"I"];
    [array_who_choices addObject:@"just you"];
    [array_who_choices addObject:@"you two"];
    [array_who_choices addObject:@"you three or more"];
    [array_who_choices addObject:@"he"];
    [array_who_choices addObject:@"she"];
    [array_who_choices addObject:@"it"];
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

-(void)Get_Output:(senecaWord*)seneca_word_object{
    
    
    //Have to parse the object
    NSLog(@"In the Get_Output method %@", self.seneca_word.english_word);
    //http://senecadictionary.com/output?inp=sing&id=1&when=did+it&who=I&done_to=&direction=
    NSString *urlGetMatchesString = [NSString stringWithFormat:@"http://senecadictionary.com/output?inp=%@&id=%@&when=%@&who=%@&done_to=%@&direction=%@", seneca_word_object.english_word, seneca_word_object.ids, seneca_word_object.when, seneca_word_object.who, seneca_word_object.done_to, seneca_word_object.direction];
    NSLog(@"The string is: %@", urlGetMatchesString);
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(300, 400);
    self.spinner.tag = 12;
    [self.view addSubview:spinner];
    [self.spinner startAnimating];
    
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

-(IBAction)nextButtonPressed:(id)sender{
    NSLog(@"The next button on the dropdown menu was pressed!");
    if(1){
        [self Get_Output:seneca_word];
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView == pickerWhen) {
        // return number of components in first picker
        NSLog(@"It's the pickerview!");
        return [array_when_choices count];
    }
    else{
        return [array_who_choices count];
    }
    //This will be changed to the count of your array

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    //NSLog(@"data for row #%d = %@", row, [arrayDates objectAtIndex:row]);
    if(pickerView == pickerWhen){
        return [array_when_choices objectAtIndex:row];
    }
    else{
        return [array_who_choices objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    //label.font = [UIFont fontWithName:@"the_hungry_ghost" size:16.0];
    //NSString *picked = [arrayDates objectAtIndex:row];
    //NSLog(@"About to be stored in the teTime property: %@", picked);
    //self.teTime.date = [arrayDates objectAtIndex:row];
    if(pickerView == pickerWhen){
        //NSString *selected_when = [array_when_choices objectAtIndex:row];
        if([[array_when_choices objectAtIndex:row] isEqual: @"did it"]){
        seneca_word.when = @"did+it";
        }
        else if([[array_when_choices objectAtIndex:row] isEqual: @"will do it"]){
            seneca_word.when = @"will+do+it";
        }
        else if([[array_when_choices objectAtIndex:row] isEqual: @"might do it"]){
            seneca_word.when = @"might+do+it";
        }
        else if([[array_when_choices objectAtIndex:row] isEqual: @"does it"]){
            seneca_word.when = @"does+it";
        }
        else if([[array_when_choices objectAtIndex:row] isEqual: @"will do it"]){
            seneca_word.when = @"will+do+it";
        }
        else if([[array_when_choices objectAtIndex:row] isEqual: @"is doing it"]){
            seneca_word.when = @"is+doing+it";
        }
        else if([[array_when_choices objectAtIndex:row] isEqual: @"has done it"]){
            seneca_word.when = @"has+done+it";
        }
        else if([[array_when_choices objectAtIndex:row] isEqual: @"do it"]){
            seneca_word.when = @"do+it";
        }
        NSLog(@"The when row picked is: %@", seneca_word.when);
    }
    else if(pickerView == picker_who){
        //seneca_word.who = [array_who_choices objectAtIndex:row];
        NSLog(@"The picker_who is being picked");
        if([[array_who_choices objectAtIndex:row] isEqual: @"I"]){
            seneca_word.who = @"I";
            NSLog(@"picker_who is: %@", seneca_word.who);
        }//if
        else if([[array_who_choices objectAtIndex:row] isEqual: @"just you"]){
            seneca_word.who = @"just+you";
            NSLog(@"picker_who is: %@", seneca_word.who);
        }//else if
    
    }//else if(pickerView == pickerView)
    //label.font = [UIFont fontWithName:[data objectAtIndex:row] size:16.0];
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
    NSLog(@"JSON: %@", jsonDict);
    NSString *string_seneca = [jsonDict objectForKey:@"seneca"];
    NSLog(@"The array_seneca is: %@", string_seneca);
    seneca_word.seneca = string_seneca;
    NSLog(@"The seneca_word is: %@", seneca_word.seneca);
    NSString *string_english = [jsonDict objectForKey:@"english"];
    seneca_word.english_output = string_english;
    NSLog(@"The english_ouput is: %@", seneca_word.english_output);
    
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
    //getMatchesDict = jsonDict;
    NSLog(@"In the class method dropdownmenuVC!");
    
    [self.spinner stopAnimating];
    
    [self performSegueWithIdentifier:@"segue_to_output" sender:self];
}//(void)connectionDidFinishLoading

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //NSLog(@"The segue identifier is: %@", [segue identifier]);
    //if ([[segue identifier] isEqualToString:@"YOUR_SEGUE_NAME_HERE"])
    
    //Creating an object for the next VC so we can send the seneca_word object to it
    dropDownMenuViewController *nextViewController = [segue destinationViewController];
    
    //Passing the seneca_word object to the next VC
    nextViewController.seneca_word = self.seneca_word;
    
}

@end
