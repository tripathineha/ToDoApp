//
//  ToDoTableViewCell.h
//  ToDoApp
//
//  Created by GlobalLogic on 16/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@class ToDoTableViewCell;

@protocol ToDoTableViewCellDelegate

- (void)getCellForDoneUpdate:(ToDoTableViewCell *)cell;

@end

@interface ToDoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak,nonatomic) id<ToDoTableViewCellDelegate> delegate;

- (void)configureCellWithToDoItem:(ToDoItem *)toDoItem;

@end
