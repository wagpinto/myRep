//
//  repController.m
//  myRep
//
//  Created by Wagner Pinto on 5/5/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import "repController.h"

static NSString *const repbyState = @"http://whoismyrepresentative.com/getall_reps_bystate.php?state=%@&output=json";
static NSString *const repbyZip = @"http:whoismyrepresentative.com/getall_mems.php?zip=%@&output=json";
static NSString *const repbyName = @"http://whoismyrepresentative.com/getall_reps_byname.php?name=%@&output=json";
static NSString *const senByName = @"http://whoismyrepresentative.com/getall_sens_byname.php?name=%@&output=json";
static NSString *const senByState = @"http://whoismyrepresentative.com/getall_sens_bystate.php?state=%@&output=json";

@implementation repController

+ (repController *)sharedInstance {
    static repController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [repController new];
        
    });
    return sharedInstance;
}

-(void)getSenatorWithInfo:(NSString *)info andSearchType:(Search)searchType completion:(void (^)(BOOL))completion {
    self.loadSenatorsArray = [NSMutableArray new];
    NSURL *url;
    
    switch (searchType) {
        case SearchByName:
            url = [NSURL URLWithString:[NSString stringWithFormat:senByName, info]];
            break;
        case SearchByState:
            url = [NSURL URLWithString:[NSString stringWithFormat:senByState, info]];
            break;
        case SearchByZip:
            break;
    }
    NSError *error;
    NSArray *array = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error]objectForKey:@"results"];
    NSMutableArray *senatorArray = [NSMutableArray new];

    for (NSDictionary *dictionary in array) {
        Rep *senator = [[Rep alloc]initWithDictionaryOfReps:dictionary];
        [senatorArray addObject:senator];
        NSLog(@"%@",senator);
    }
    if (array) {
        self.loadSenatorsArray = senatorArray;
        completion (YES);
    }
    
}
- (void)getRepresentativeWithInfo:(NSString *)info andSearchType:(Search)searchType completion:(void (^)(BOOL))completion {
    self.loadRepArray = [NSMutableArray new];
    NSURL *url;
    
    switch (searchType) {
        case SearchByName:
            url = [NSURL URLWithString:[NSString stringWithFormat:repbyName, info]];
            break;
        case SearchByZip:
            url = [NSURL URLWithString:[NSString stringWithFormat:repbyZip, info]];
            break;
        case SearchByState:
            url = [NSURL URLWithString:[NSString stringWithFormat:repbyState, info]];
            break;
    }
    NSError *error;
    NSArray *array = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error]objectForKey:@"results"];
    NSMutableArray *repArray = [NSMutableArray new];
    
    for (NSDictionary *dictionary in array) {
        Rep *representative = [[Rep alloc]initWithDictionaryOfReps:dictionary];
        [repArray addObject:representative];
    }
    if (array) {
        self.loadRepArray = repArray;
        completion (YES);
    }
}
@end
