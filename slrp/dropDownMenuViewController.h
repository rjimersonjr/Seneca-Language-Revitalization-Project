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
    NSMutableArray *array_when_choices;
    //NSString *dateStringToMove;
    //teeTime *teTime;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

@property(nonatomic, strong) senecaWord *seneca_word;
@property(nonatomic, strong) UILabel *lblEnglish_input;
@property(nonatomic, strong) UILabel *lblEnglish;
@end
