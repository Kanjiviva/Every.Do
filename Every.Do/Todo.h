//
//  Todo.h
//  Every.Do
//
//  Created by Steve on 2015-09-08.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (strong, nonatomic) NSString *todoTitle;
@property (strong, nonatomic) NSString *todoDescription;
@property (assign, nonatomic) int todoPriorityNumber;
@property (assign, nonatomic) BOOL isCompleted;
@property (strong, nonatomic) NSDate *deadline;

- (instancetype)initWithTitle:(NSString *)title descrip:(NSString *)descrip priorityNumber:(int)priorityNumber isCompleted:(BOOL)isCompleted deadline:(NSDate *)deadline;

@end
