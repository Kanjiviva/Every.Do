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

- (IBAction)pickUpDate:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation AddListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)goBackButton:(id)sender {

    self.object = [[Todo alloc] initWithTitle:self.titleTextField.text descrip:self.descriptionTextField.text priorityNumber:(int)self.prioritySegment.selectedSegmentIndex + 1 isCompleted:self.isCompletedSwitch.on deadline:self.datePicker.date];
    
    [self.delegate addNewListToArray:self.object];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (IBAction)pickUpDate:(UIDatePicker *)sender {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];

}
@end
