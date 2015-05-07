//
//  ViewController.m
//  myRep
//
//  Created by Wagner Pinto on 5/5/15.
//  Copyright (c) 2015 weeblu.co llc. All rights reserved.
//

#import "repViewController.h"
#import "repDetailViewController.h"


@interface repViewController ()

@property (nonatomic, strong) NSArray *loadRep;
@property (nonatomic, strong) NSArray *loadSenator;

@end

@implementation repViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchSegmentControlle.selectedSegmentIndex = 2;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"repSelected"]) {
        NSIndexPath *indexPath = [self.tableview indexPathForCell:sender];
        repDetailViewController *detailViewController = [segue destinationViewController];
        
        switch (indexPath.section) {
            case 0:
                [detailViewController updateViewWithInfo:[repController sharedInstance].loadRepArray[indexPath.row]];
                break;
            default:
                [detailViewController updateViewWithInfo:[repController sharedInstance].loadSenatorsArray[indexPath.row]];
                break;
        }
    }
}

- (IBAction)selectSearchType:(id)sender {

    if (!self.searchSegmentControlle) {
        NSLog(@"SELECT A SEGMENT");
    }else {
        switch (self.searchSegmentControlle.selectedSegmentIndex) {
            case 0:
                [self getRepresentative:self.searchTextField.text andType:SearchByZip];
                break;
            case 1:
                [self getRepresentative:self.searchTextField.text andType:SearchByName];
                [self getSenator:self.searchTextField.text andType:SearchByName];
                break;
            case 2:
                [self getRepresentative:self.searchTextField.text andType:SearchByState];
                [self getSenator:self.searchTextField.text andType:SearchByState];
                break;
        }
    }
}

#pragma mark - TEXTFIELD DELEGATE
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

#pragma mark - GET JSON API
- (void)getRepresentative:(NSString *)info andType:(Search)type {
    //manage thread when getting the
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
         [[repController sharedInstance] getRepresentativeWithInfo:self.searchTextField.text andSearchType:type completion:^(BOOL success) {
            if (success) {
                self.loadRep = [repController sharedInstance].loadRepArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            } else {
                //Alert user of the problem - check information on search bar.
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Search Fail"
                                                                                    message:@"Plase check the information"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:errorAlert animated:YES completion:nil];
            }
         }];
    });
}
- (void)getSenator:(NSString *)info andType:(Search)type {
    //manage thread when getting the
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[repController sharedInstance] getSenatorWithInfo:self.searchTextField.text andSearchType:type completion:^(BOOL success) {
            if (success) {
                self.loadSenator = [repController sharedInstance].loadSenatorsArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            } else {
                //Alert user of the problem - check information on search bar.
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Search Fail"
                                                                                    message:@"Plase check the information"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
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

    long repCount = [repController sharedInstance].loadRepArray.count;
    long senCount = [repController sharedInstance].loadSenatorsArray.count;
    NSString *sectionName;

    switch (section) {
        case 0:
            return sectionName = [NSString stringWithFormat:@"%ld Representatives",repCount];
            break;
        default:
            return sectionName = [NSString stringWithFormat:@"%ld Senators",senCount];
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    searchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repCell" forIndexPath:indexPath];
    Rep *rep = [repController sharedInstance].loadRepArray[indexPath.row];
    
    cell.searchResultLabel.text = rep.repName;

    if ([rep.repParty isEqual: @"R"]) {
        cell.partyImageView.image = [UIImage imageNamed:@"Republican"];
        cell.partyLabel.backgroundColor = [UIColor blueColor];
    }else {
        cell.partyImageView.image = [UIImage imageNamed:@"Democratic"];
        cell.partyLabel.backgroundColor = [UIColor redColor];
    }
        
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
