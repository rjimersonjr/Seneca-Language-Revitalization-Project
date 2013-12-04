//
//  outputViewController.h
//  slrp
//
//  Created by Robert Jimerson Jr on 12/4/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "senecaWord.h"

@interface outputViewController : UIViewController

@property(nonatomic, strong) senecaWord *seneca_word;
@property(nonatomic, strong) UILabel *lblEnglish_ouput;
@property(nonatomic, strong) UILabel *lblSeneca_output;
@end
