//
//  slrpViewController.h
//  slrp
//
//  Created by Robert Jimerson Jr on 8/6/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "senecaWord.h"

@interface slrpViewController : UIViewController<UITextFieldDelegate>{
    NSString *buttonHit;
}

-(IBAction)dismissKeyboard;
-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)resetButtonPressed:(id)sender;


@property (nonatomic, retain) IBOutlet UITextField *eWordEntered;

@property (nonatomic, strong) senecaWord *eWord;


@end
