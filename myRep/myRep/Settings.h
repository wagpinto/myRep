//
//  Settings.h
//  myRep
//
//  Created by Wagner Pinto on 5/5/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import <Foundation/Foundation.h>

//Settings class has a global aspect
//Focused on properties and method that are used multiple times.

typedef NS_ENUM (NSInteger, Search) {
    SearchByZip,
    SearchByState,
    SearchByName,
};

@interface Settings : NSObject



@end
