//
//  AddToDoViewController.h
//  ToDoApp
//
//  Created by GlobalLogic on 14/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ShowAlert.h"
#import "DataManager.h"
#import "NSDate+LocalizedDate.h"

@interface AddToDoViewController : UIViewController <UITextFieldDelegate>

@property (strong,nonatomic) NSManagedObjectID *objectId;

@end
