//
//  Todo.m
//  Every.Do
//
//  Created by Steve on 2015-09-08.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithTitle:(NSString *)title descrip:(NSString *)descrip priorityNumber:(int)priorityNumber isCompleted:(BOOL)isCompleted
{
    self = [super init];
    if (self) {
        
        _todoTitle = title;
        _todoDescription = descrip;
        _todoPriorityNumber = priorityNumber;
        _isCompleted = isCompleted;

    }
    return self;
}

@end
