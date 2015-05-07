//
//  repDetailViewController.m
//  myRep
//
//  Created by Wagner Pinto on 5/6/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import "repDetailViewController.h"

@implementation repDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void)setupViewController {
    
    self.repNameLabel.text = self.rep.repName;
    self.repPartyLabel.text = self.rep.repParty;
    self.repPhoneLabel.text = self.rep.repPhone;
    self.repAddressLabal.text = self.rep.repOffice;
    self.repDistrictLabel.text = self.rep.repDistrict;
    self.repWebsiteLabel.text = self.rep.repWebsite;

}

- (void)updateViewWithInfo:(Rep *)rep {
    self.rep = rep;
    
}

@end
