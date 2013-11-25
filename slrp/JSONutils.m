//
//  JSONutils.m
//  slrp
//
//  Created by Robert Jimerson Jr on 8/12/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import "JSONutils.h"

@implementation JSONutils
@synthesize responseData;
@synthesize getMatchesDict;
@synthesize isFinished;

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
    
    
}//(void)connectionDidFinishLoading
@end
