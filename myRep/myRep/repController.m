//
//  repController.m
//  myRep
//
//  Created by Wagner Pinto on 5/5/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import "repController.h"

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
    self.senatorsArray = [NSMutableArray new];
    NSURL *url;
    
    switch (searchType) {
        case SearchByName:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_sens_byname.php?name=%@&output=json", info]];
            break;
        case SearchByState:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_sens_bystate.php?state=%@&output=json", info]];
            break;
        case SearchByZip:
            break;
    }
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableArray *senatorArray = [NSMutableArray new];
    for (NSDictionary *dictionary in array) {
        Rep *senator = [[Rep alloc]initWithDictionaryOfReps:dictionary];
        [senatorArray addObject:senator];
        NSLog(@"%@",senator);
    }
}
- (void)getRepresentativeWithInfo:(NSString *)info andSearchType:(Search)searchType completion:(void (^)(BOOL))completion {
    self.representativeArray = [NSMutableArray new];
    NSURL *url;
    
    switch (searchType) {
        case SearchByName:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http:whoismyrepresentative.com/getall_mems.php?zip=%@&output=json", info]];
            break;
        case SearchByZip:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_reps_bystate.php?state=%@&output=json", info]];
            break;
        case SearchByState:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_reps_byname.php?name=%@&output=json", info]];
            break;
    }
    NSError *error;
    NSArray *array = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error]objectForKey:@"results"];
    
    NSMutableArray *repArray = [NSMutableArray new];
    for (NSDictionary *dictionary in array) {
        Rep *representative = [[Rep alloc]initWithDictionaryOfReps:dictionary];
        [repArray addObject:representative];
        NSLog(@"%@",representative);
    }
}
@end
