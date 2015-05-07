//
//  repDetailViewController.h
//  myRep
//
//  Created by Wagner Pinto on 5/6/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface repDetailViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *repNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *repAddressLabal;
@property (weak, nonatomic) IBOutlet UILabel *repPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *repWebsiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *repPartyLabel;
@property (weak, nonatomic) IBOutlet UILabel *repDistrictLabel;

@end
