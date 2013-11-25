//
//  slrpViewController.h
//  slrp
//
//  Created by Robert Jimerson Jr on 8/6/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "senecaWord.h"
#import "dropDownMenuViewController.h"

@interface slrpViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSString *buttonHit;
    //UILabel *lblWhen;
    UIPickerView *whenPicker;
    UIPickerView *whoPicker;
    NSMutableArray *dataArray;
}

-(IBAction)dismissKeyboard;
-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)resetButtonPressed:(id)sender;


@property(nonatomic, retain) IBOutlet UITextField *eWordEntered;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, retain) UIPickerView *whenPicker;
@property(nonatomic, retain) UIPickerView *whoPicker;
@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, strong) senecaWord *seneca_word;


@end
