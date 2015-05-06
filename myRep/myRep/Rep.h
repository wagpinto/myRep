//
//  Rep.h
//  myRep
//
//  Created by Wagner Pinto on 5/5/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rep : NSObject

@property (nonatomic, strong) NSString *repName;
@property (nonatomic, strong) NSString *repParty;
@property (nonatomic, strong) NSString *repState;
@property (nonatomic, strong) NSString *repDistrict;
@property (nonatomic, strong) NSString *repPhone;
@property (nonatomic, strong) NSString *repOffice;
@property (nonatomic, strong) NSString *repWebsite;

- (instancetype)initWithDictionaryOfReps:(NSDictionary *)dictionary;

@end
