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
    //IBOutlet UIPickerView *picker_choice;
    NSMutableArray *dataArray;
    NSMutableData *receivedData;
    
    NSMutableArray *pastUrls;
    NSMutableArray *autocompleteUrls;
    UITableView *autocompleteTableView;
}

-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)directionalButtonPressed:(id)sender;
-(IBAction)resetButtonPressed:(id)sender;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

@property(nonatomic, retain) IBOutlet UITextField *eWordEntered;
@property(nonatomic, retain) UIActivityIndicatorView *spinner;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, retain) UIPickerView *whenPicker;
@property(nonatomic, retain) UIPickerView *whoPicker;
@property(nonatomic, retain) IBOutlet UIPickerView *directionalPicker;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property(nonatomic, retain) IBOutlet UIButton *nextDirectionalButton;

@property (nonatomic, strong) senecaWord *seneca_word;
@property (nonatomic, strong) NSArray *auto_complete_array;
@property (nonatomic, retain) NSMutableArray *pastUrls;
@property (nonatomic, retain) NSMutableArray *autocompleteUrls;

//-(NSDictionary *)Go_Between_Method:(NSDictionary *)returnedMatchesDict;

@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) NSDictionary *getMatchesDict;
@property (nonatomic) BOOL *directionSelected;
@property (nonatomic, retain) UITableView *autocompleteTableView;

-(void)setReceivedData:(NSMutableData*)pReceivedData;
-(void)buildDirectionalMenu:(NSDictionary*)choiceDict;
-(void)Get_Matches:(NSString*)englishWord;
-(NSMutableData *) getReceivedData;
-(void) getAutoCompleteArray;
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

@end
