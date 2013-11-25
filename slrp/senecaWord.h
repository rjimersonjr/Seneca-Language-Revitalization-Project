//
//  senecaWord.h
//  slrp
//
//  Created by Robert Jimerson Jr on 8/6/13.
//  Copyright (c) 2013 Robert Jimerson Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface senecaWord : NSObject

@property(nonatomic, strong) NSString *english_input;
@property(nonatomic, strong) NSString *ids;
@property(nonatomic, strong) NSString *base_props;
@property(nonatomic, strong) NSString *see_also;

@property(nonatomic, strong) NSString *pronominal_prefix;
@property(nonatomic, strong) NSString *modal;
@property(nonatomic, strong) NSString *base;

@property(nonatomic, strong) NSString *seneca;
@property(nonatomic, strong) NSString *english_output;
@property(nonatomic, strong) NSString *sound;


@end
