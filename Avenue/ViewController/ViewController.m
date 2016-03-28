//
//  ViewController.m
//  Avenue
//
//  Created by Ana Finotti on 3/27/16.
//  Copyright © 2016 Finotti. All rights reserved.
//

#import "ViewController.h"
#import "AvenueService.h"
#import "ResponseCell.h"
#import "HeaderCell.h"
#import "Sf.h"
#import <MBProgressHUD.h>

@interface ViewController ()

@property (nonatomic, strong) Sf *sf;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupTableView];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupNavigationBar {

    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    label.textColor = [UIColor blackColor];
    
    label.text = @"Avenue";
    label.frame = CGRectMake(0, 0, 44, 44);
    
    self.navigationItem.titleView = label;
}

- (void)setupView {
    self.searchTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.searchTextField.layer.borderWidth = 1.0f;
    self.searchTextField.layer.cornerRadius = 5;
    self.searchTextField.layer.masksToBounds = YES;
    
    self.searchButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.searchButton.backgroundColor = [UIColor lightGrayColor];
    self.searchButton.layer.borderWidth = 1.0f;
    self.searchButton.layer.cornerRadius = 7;
    self.searchButton.layer.masksToBounds = YES;
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)searchCorrespondingMeanings {
    
    if(![self validateField])
        return;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AvenueService getSf:self.searchTextField.text success:^(Sf *sfResponse) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        self.sf = sfResponse;
        
        [self showResultsLabel];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@", error);
    }];
}

- (void)showResultsLabel {
    
    NSString *result;
    
    if([self.sf.lfs count] > 0) {
       [self.resultsLabel setHidden:NO];
        result = @"Results for '";
    }
    else {
        [self.resultsLabel setHidden:NO];
        result = @"No records were found for the search '";
    }
    
    self.resultsLabel.text = [NSString stringWithFormat:@"%@%@%@", result, self.searchTextField.text, @"'"];
}

-(BOOL)validateField {
    if([self.searchTextField.text isEqualToString:@""]) {
        [self showAlert];
        return NO;
    }
    return YES;
}

-(void)showAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Search field must not be empty!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", "OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:ok];
  
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Events
- (IBAction)searchButtonTouchUpInside:(id)sender {
    [self.resultsLabel setHidden:YES];
    [self searchCorrespondingMeanings];
}

#pragma mark UITableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResponseCell *cell = (ResponseCell *)[tableView dequeueReusableCellWithIdentifier:@"ResponseCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ResponseCell" bundle:nil] forCellReuseIdentifier:@"ResponseCell"];
        cell = (ResponseCell *)[tableView dequeueReusableCellWithIdentifier:@"ResponseCell"];
    }
    
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = .5f;
    cell.layer.masksToBounds = YES;
    
    
    Lfs *lfs = [[Lfs alloc] init];
    lfs = [self.sf.lfs objectAtIndex:indexPath.section];
    
    Vars *vars = [[Vars alloc] init];
    vars = [lfs.vars objectAtIndex:indexPath.row];
    
    cell.lfLabel.text = vars.lf;
    cell.lfLabel.adjustsFontSizeToFitWidth = YES;
    cell.freqLabel.text = vars.freq.stringValue;
    cell.sinceLabel.text = vars.since.stringValue;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderCell *cell = (HeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellReuseIdentifier:@"HeaderCell"];
        cell = (HeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    }
    
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = .5f;
    cell.layer.masksToBounds = YES;
    
    Lfs *lfs = [[Lfs alloc] init];
    lfs = [self.sf.lfs objectAtIndex:section];
    
    cell.lfLabel.text = lfs.lf;
    cell.lfLabel.adjustsFontSizeToFitWidth = YES;
    cell.freqLabel.text = lfs.freq.stringValue;
    cell.sinceLabel.text = lfs.since.stringValue;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 65;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Lfs *lfs = [[Lfs alloc] init];
    lfs = [self.sf.lfs objectAtIndex:section];
    return lfs.vars.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sf.lfs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
