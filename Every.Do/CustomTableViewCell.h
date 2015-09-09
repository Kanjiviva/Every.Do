//
//  CustomTableViewCell.h
//  Every.Do
//
//  Created by Steve on 2015-09-08.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *priorityNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *isCompletedLabel;
@property (strong, nonatomic) IBOutlet UILabel *completedDate;

@end
