//
//  MasterViewController.m
//  Every.Do
//
//  Created by Steve on 2015-09-08.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "CustomTableViewCell.h"
#import "AddListViewController.h"

@interface MasterViewController () <AddListViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeToComplete;
- (IBAction)swipeToComplete:(UISwipeGestureRecognizer *)sender;

@property NSMutableArray *objects;

@property (strong, nonatomic) NSMutableArray *sectionArray;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.sectionArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *sectionOne = [[NSMutableArray alloc] init];
    NSMutableArray *sectionTwo = [[NSMutableArray alloc] init];
    
    [self.sectionArray addObject:sectionOne];
    [self.sectionArray addObject:sectionTwo];
    
    NSDate *today = [[NSDate alloc] init];
    NSLog(@"%@", today);
    
    NSTimeInterval secondsPerDay = 60 * 60 * 24;
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
    NSLog(@"%@", tomorrow);

    Todo *todo1 = [[Todo alloc] initWithTitle:@"School" descrip:@"Go to class at 9am and don't be late" priorityNumber:1 isCompleted:YES deadline:today];
    Todo *todo2 = [[Todo alloc] initWithTitle:@"Eat" descrip:@"Eat Lunch. Make sure to eat healthy" priorityNumber:3 isCompleted:YES deadline:tomorrow];
    Todo *todo3 = [[Todo alloc] initWithTitle:@"Homework" descrip:@"Complete the assignment so I can go home early!!" priorityNumber:2 isCompleted:NO deadline:today];
    
    self.objects = [NSMutableArray new];
    
    [self.objects addObject:todo1];
    [self.objects addObject:todo2];
    [self.objects addObject:todo3];
    
    [self divideArrayToSection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    } else if ([segue.identifier isEqualToString:@"showAddList"]) {
        
        AddListViewController *addlistVC = segue.destinationViewController;
        
        addlistVC.delegate = self;
        
    }
}

#pragma mark - Helper methods

- (void)divideArrayToSection {
    
    for (Todo *todo in self.objects) {
        if (!todo.isCompleted) {
            
            
            //not completed section
            [self.sectionArray[0] addObject:todo];
            
        } else {
            
            //completed section
            [self.sectionArray[1] addObject:todo];
        }
    }

}

#pragma mark - Add list delegate

- (void)addNewListToArray:(Todo *)object {
    
    if (object.isCompleted) {
        [self.sectionArray[1] addObject:object];
    } else {
        [self.sectionArray[0] addObject:object];
    }
    
}

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *getSection = self.sectionArray[indexPath.section];
    
    // config cell
    Todo *object = [getSection objectAtIndex:indexPath.row];
    
//    NSLog(@"Object is now %@", object.todoTitle);
    
    cell.titleLabel.text = object.todoTitle;
    cell.descriptionLabel.text = object.todoDescription;
    cell.priorityNumberLabel.text = [NSString stringWithFormat:@"%i", object.todoPriorityNumber];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];

    cell.completedDate.text = [dateFormatter stringFromDate:object.deadline];
    
    if (object.isCompleted) {
        cell.isCompletedLabel.text = @"Completed";
    } else {
        cell.isCompletedLabel.text = @"Not completed";
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        NSInteger sourceRow = sourceIndexPath.row;
        NSInteger destRow = destinationIndexPath.row;
        id object = [self.objects objectAtIndex:sourceRow];
        
        [self.objects removeObjectAtIndex:sourceRow];
        [self.objects insertObject:object atIndex:destRow];
        
        
    } else {
        [self.tableView reloadData];
    }
    
    
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return [NSString stringWithFormat:@"Completed"];
    } else if (section == 1){
        return [NSString stringWithFormat:@"Not Completed"];
    } else {
        return nil;
    }
    
    
//    return [NSString stringWithFormat:@"Completed %li", (long)section + 1];
}

#pragma mark - IBActions

- (IBAction)swipeToComplete:(UISwipeGestureRecognizer *)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];
    
    NSMutableArray *section = self.sectionArray[indexPath.section];
    
    Todo *object = [section objectAtIndex:indexPath.row];
    
    
    if (object.isCompleted == NO) {
        object.isCompleted = YES;
        
        [self.sectionArray[0] removeObject:object];
        [self.sectionArray[1] addObject:object];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
    else {
        
        NSLog(@"Completed already");
    }
    
}

@end
