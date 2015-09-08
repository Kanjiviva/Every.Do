//
//  AddListViewController.h
//  Every.Do
//
//  Created by Steve on 2015-09-08.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@protocol AddListViewControllerDelegate <NSObject>

-(void)addNewListToArray:(Todo *)object;

@end


@interface AddListViewController : UIViewController

@property (strong, nonatomic) id<AddListViewControllerDelegate> delegate;
@property (strong, nonatomic) Todo *object;

@end
