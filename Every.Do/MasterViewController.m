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
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    Todo *todo1 = [[Todo alloc] initWithTitle:@"School" descrip:@"Go to class at 9am and don't be late" priorityNumber:1 isCompleted:NO];
    Todo *todo2 = [[Todo alloc] initWithTitle:@"Eat" descrip:@"Eat Lunch. Make sure to eat healthy" priorityNumber:3 isCompleted:NO];
    Todo *todo3 = [[Todo alloc] initWithTitle:@"Homework" descrip:@"Complete the assignment so I can go home early!!" priorityNumber:2 isCompleted:NO];
    
    self.objects = [NSMutableArray new];
    
    [self.objects addObject:todo1];
    [self.objects addObject:todo2];
    [self.objects addObject:todo3];
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

#pragma mark - Add list delegate

- (void)addNewListToArray:(Todo *)object {
    
    [self.objects addObject:object];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // config cell
    Todo *object = [self.objects objectAtIndex:indexPath.row];
    
//    NSLog(@"Object is now %@", object.todoTitle);
    
    cell.titleLabel.text = object.todoTitle;
    cell.descriptionLabel.text = object.todoDescription;
    cell.priorityNumberLabel.text = [NSString stringWithFormat:@"%i", object.todoPriorityNumber];
    
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

#pragma mark - IBActions

- (IBAction)swipeToComplete:(UISwipeGestureRecognizer *)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];
    
    Todo *object = [self.objects objectAtIndex:indexPath.row];
    
    
    if (!object.isCompleted) {
        object.isCompleted = YES;
        
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        NSLog(@"Completed already");
    }
    
}
@end
