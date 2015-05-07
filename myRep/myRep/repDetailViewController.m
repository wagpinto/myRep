//
//  repDetailViewController.m
//  myRep
//
//  Created by Wagner Pinto on 5/6/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import "repDetailViewController.h"
#import <MapKit/MapKit.h>

@interface repDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *goToWebsite;

@end

@implementation repDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //call methods here:
    [self setupViewController];
}

- (void)setupViewController {
    //setup the view controller with data selected on main view:
    self.repNameLabel.text = self.rep.repName;
    self.repPhoneLabel.text = self.rep.repPhone;
    self.repAddressLabal.text = self.rep.repOffice;
    self.repDistrictLabel.text = [NSString stringWithFormat:@"District: %@",self.rep.repDistrict];
    self.repWebsiteLabel.text = self.rep.repWebsite;
    self.titleLabel.text = [NSString stringWithFormat:@"%@ - %@",self.rep.repName, self.rep.repState];

    //check if thre's website and phone in database:
    if (self.repPhoneLabel.text == nil || self.repWebsiteLabel.text == nil) {
        self.repPhoneLabel.text = @"NO PHONE";
        self.repWebsiteLabel.text = @"NO WEBSITE";
        self.callButton.enabled = NO;
        self.goToWebsite.enabled = NO;
    }
    //rename the party label:
    if ([self.rep.repParty isEqualToString:@"D"]) {
        self.titleLabel.backgroundColor = [UIColor blueColor];
        self.repPartyLabel.text = [NSString stringWithFormat:@"Party: DEMOCART"];
    }else {
        self.titleLabel.backgroundColor = [UIColor redColor];
        self.repPartyLabel.text = [NSString stringWithFormat:@"Party: REPUBLICAN"];
    }
}

- (void)updateViewWithInfo:(Rep *)rep {
    //set the view with data selected on main view.
    self.rep = rep;
    
}
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)callRepOffice:(id)sender {
    
    NSURL *phoneCall = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.repPhoneLabel.text]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneCall]) {
        [[UIApplication sharedApplication] openURL:phoneCall];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Call can't be done!" message:@"Pleae try to call another number if available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)goToWebPage:(id)sender {
    NSURL *url = [NSURL URLWithString:self.repWebsiteLabel.text];
    [[UIApplication sharedApplication] openURL:url];
    
}
#pragma mark - TABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
