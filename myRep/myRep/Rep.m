//
//  Rep.m
//  myRep
//
//  Created by Wagner Pinto on 5/5/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import "Rep.h"

static NSString *const repNameKey = @"name";
static NSString *const repStateKey = @"state";
static NSString *const repPartyKey = @"party";
static NSString *const repDistrictKey = @"district";
static NSString *const repPhoneKey =@"phone";
static NSString *const repOfficeKey = @"office";
static NSString *const repWebpage = @"link";

@implementation Rep

- (instancetype)initWithDictionaryOfReps:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        //JSON properties from the given API.
        self.repName = dictionary[repNameKey];
        self.repState = dictionary[repStateKey];
        self.repParty = dictionary[repPartyKey];
        self.repDistrict = dictionary[repDistrictKey];
        self.repPhone = dictionary[repPhoneKey];
        self.repOffice = dictionary[repOfficeKey];
        self.repWebsite = dictionary[repWebpage];
    }
    return self;
}

@end
