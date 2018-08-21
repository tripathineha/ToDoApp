//
//  ToDoTableViewController.h
//  ToDoApp
//
//  Created by GlobalLogic on 17/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "ToDoTableViewCell.h"

@interface ToDoTableViewController : UITableViewController<NSFetchedResultsControllerDelegate,ToDoTableViewCellDelegate>

@end
