//
//  JSONutils.h
//  slrp
//
//  Created by Robert Jimerson Jr on 8/12/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONutils : NSObject{
    NSMutableData *receivedData;
}
@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) NSDictionary *getMatchesDict;
@property (nonatomic) BOOL *isFinished;

-(void)Get_Matches:(NSString*)englishWord;
//-(NSDictionary *)Go_Between_Method:(NSDictionary *)returnedMatchesDict;

-(void)setReceivedData:(NSMutableData*)pReceivedData;

-(NSMutableData *) getReceivedData;

@end
