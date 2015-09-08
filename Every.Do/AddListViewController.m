//
//  AddListViewController.m
//  Every.Do
//
//  Created by Steve on 2015-09-08.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "AddListViewController.h"


@interface AddListViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
//@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
//@property (weak, nonatomic) IBOutlet UITextField *isCompletedTextField;
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UISwitch *isCompletedSwitch;



@end

@implementation AddListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)goBackButton:(id)sender {

    self.object = [[Todo alloc] initWithTitle:self.titleTextField.text descrip:self.descriptionTextField.text priorityNumber:(int)self.prioritySegment.selectedSegmentIndex + 1 isCompleted:self.isCompletedSwitch.on];
    
    [self.delegate addNewListToArray:self.object];

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
