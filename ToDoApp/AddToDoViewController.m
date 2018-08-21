//
//  AddToDoViewController.m
//  ToDoApp
//
//  Created by GlobalLogic on 14/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "AddToDoViewController.h"
#import "NotificationManager.h"

@interface AddToDoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *toDoTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *toDoAtTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *toDoAtDatePicker;
@property (nonatomic) NSManagedObjectContext *tempMOC;
- (IBAction)onSaveButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)onCancelButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)onToDoDatePickerValueChanged:(UIDatePicker *)sender;
@property (strong,nonatomic) ToDoItem *toDoItem;

@end

@implementation AddToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tempMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _tempMOC.parentContext = [DataManager.sharedInstance managedObjectContext];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDate *date = [NSDate date];
    
    if (_objectId) {
        _toDoItem = [_tempMOC objectWithID:_objectId];
        _toDoTitleTextField.text = _toDoItem.title;
        date = _toDoItem.toDoAt;
        _toDoAtDatePicker.date = date;
    } else {
        _toDoItem = (ToDoItem *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext: _tempMOC];
    }

    _toDoAtTextField.text = date.localizedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction Methods

/**
 Validates the input and saves it if validated */
- (IBAction)onSaveButtonTapped:(UIBarButtonItem *)sender {
    
    if (_toDoTitleTextField.text.length == 0) {
        [self showAlertWithTitle: @"alert" message:@"title_field_empty" cancelAction:NO completion:nil];
        return;
    }
    // Check whether the current time is more than the set time for notification
    if ([[NSDate date] compare:_toDoAtDatePicker.date] != NSOrderedAscending) {
        [self showAlertWithTitle: @"alert" message:@"date_not_proper" cancelAction:NO completion:nil];
        return;
    }
    
    if (_objectId) {
        [NotificationManager.sharedInstance removeNotificationForToDoItem: _toDoItem];
    }
    
    [self saveToDoItem];
    [NotificationManager.sharedInstance createNotificationWithToDoItem:_toDoItem];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onCancelButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onToDoDatePickerValueChanged:(UIDatePicker *)sender {
    _toDoAtTextField.text = sender.date.localizedString;
    _toDoItem.toDoAt = sender.date;
}

#pragma mark :- UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // updating the toDoItem
    if ([textField.text length]) {
        if (textField == _toDoTitleTextField) {
            _toDoItem.title = textField.text;
        }
    }
    return true;
}

#pragma mark :- Custom Method

// Save the toDoItem to the mainManagedObjectContext
- (void)saveToDoItem {

    // A nested perfromBlock - used to store data in the persistentStore
    [_tempMOC performBlock:^{
        NSError *error = nil;
        
        // If there are any changes in the _tempMOC then save operation is performed.
        if ([_tempMOC hasChanges] && ![_tempMOC save:&error]) {
            // Error ocured while saving the toDoItem
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            [self showAlertWithTitle: @"Error" message:error.localizedDescription cancelAction:NO completion:nil];
            return;
        }
        
        NSManagedObjectContext *main_MOC = DataManager.sharedInstance.managedObjectContext;
        [DataManager.sharedInstance.managedObjectContext performBlock:^{
            NSError *error = nil;
            // If there are any changes in the main_MOC then save operation is performed.
            if ([main_MOC hasChanges] && ![main_MOC save:&error]) {
                // Error ocured while saving the toDoItem
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                [self showAlertWithTitle: @"Error" message:error.localizedDescription cancelAction:NO completion:nil];
                return;
            }
        }];
        
    }];
}


@end
