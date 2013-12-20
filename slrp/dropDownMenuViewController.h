//
//  dropDownMenuViewController.h
//  slrp
//
//  Created by Robert Jimerson Jr on 8/12/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "senecaWord.h"

@interface dropDownMenuViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    
    IBOutlet UIPickerView *pickerWhen;
    IBOutlet UIPickerView *picker_who;
    NSMutableArray *array_when_choices;
    NSMutableArray *array_who_choices;
    NSMutableArray *dataArray;
    NSMutableData *receivedData;
}

-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)resetButtonPressed:(id)sender;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

-(void)setReceivedData:(NSMutableData*)pReceivedData;
-(NSMutableData *) getReceivedData;
-(void)Get_Output:(NSObject*)seneca_word_object;

@property(nonatomic, strong) senecaWord *seneca_word;
@property(nonatomic, strong) UIActivityIndicatorView *spinner;
@property(nonatomic, strong) UILabel *lblEnglish_input;
@property(nonatomic, strong) UILabel *lblEnglish;
@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) NSDictionary *getMatchesDict;
@end
