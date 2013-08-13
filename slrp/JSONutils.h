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

-(void)Get_Matches:(NSString*)englishWord;

-(void)setReceivedData:(NSMutableData*)pReceivedData;

-(NSMutableData *) getReceivedData;

@end
