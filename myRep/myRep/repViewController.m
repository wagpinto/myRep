//
//  ViewController.m
//  myRep
//
//  Created by Wagner Pinto on 5/5/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import "repViewController.h"


@interface repViewController ()

@property (nonatomic, strong) NSArray *loadRep;
@property (nonatomic, assign) long search;

@end

@implementation repViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupSearchType];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)setupSearchType {

    switch (self.searchSegmentControlle.selectedSegmentIndex) {
        case 0:
            self.search = SearchByZip;
            break;
        case 1:
            self.search = SearchByName;
            break;
        case 2:
            self.search = SearchByState;
            break;
            
    }
}

#pragma mark - TEXTFIELD DELEGATE
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [self setupSearchType];
    [self getRepresentative:self.searchTextField.text andType:SearchByZip];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - GET JSON API
- (void)getRepresentative:(NSString *)info andType:(Search)type {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
         [[repController sharedInstance] getRepresentativeWithInfo:self.searchTextField.text andSearchType:type completion:^(BOOL success) {
            if (success) {
                self.loadRep = [repController sharedInstance].loadRepArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            } else {
                //Alert user of the problem - check information on search bar.
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Search Fail" message:@"Plase check the information" preferredStyle:UIAlertControllerStyleAlert];
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:errorAlert animated:YES completion:nil];
            }
         }];
    });
}

#pragma mark - TABELVIEW DELEGATE | DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return [repController sharedInstance].loadRepArray.count;
            break;
        default:
            return [repController sharedInstance].loadSenatorsArray.count;
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return @"Representatives:";
            break;
        default:
            return @"Senator";
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    searchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repCell" forIndexPath:indexPath];
    Rep *rep = [repController sharedInstance].loadRepArray[indexPath.row];
    
    cell.searchResultLabel.text = rep.repName;
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
