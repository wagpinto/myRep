//
//  ViewController.h
//  myRep
//
//  Created by Wagner Pinto on 5/5/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "repController.h"
#import "searchResultCell.h"
#import "repController.h"
#import "Settings.h"

@interface repViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *searchSegmentControlle;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

