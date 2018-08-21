//
//  UIViewController+ShowAlert.h
//  ToDoApp
//
//  Created by GlobalLogic on 16/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShowAlert)

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelAction:(BOOL)cancel completion:(void (^)(UIAlertAction *))completion;

@end
