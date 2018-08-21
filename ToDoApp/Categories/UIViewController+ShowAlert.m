//
//  UIViewController+ShowAlert.m
//  ToDoApp
//
//  Created by GlobalLogic on 16/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "UIViewController+ShowAlert.h"
#import "LocalizationHeaders.h"

@implementation UIViewController (ShowAlert)

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelAction:(BOOL)cancel completion:(void (^)(UIAlertAction *))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: localizedString(title) message: localizedString(message) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:completion]];
    
    if (cancel) {
        [alert addAction:[UIAlertAction actionWithTitle:localizedString(@"Cancel") style:UIAlertActionStyleDefault handler:nil]];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
