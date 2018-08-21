//
//  ToDoTableViewCell.m
//  ToDoApp
//
//  Created by GlobalLogic on 16/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "ToDoTableViewCell.h"
#import "NSDate+LocalizedDate.h"

@interface ToDoTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDoAtLabel;

- (IBAction)onDoneTapped:(UIButton *)sender;
- (void)setUpDoneButtonWithSelection:(BOOL)selected;

@end
@implementation ToDoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellWithToDoItem:(ToDoItem *)toDoItem {
    _titleLabel.text = toDoItem.title;
    _toDoAtLabel.text = toDoItem.toDoAt.localizedString;
    [self setUpDoneButtonWithSelection:toDoItem.done];
}

- (IBAction)onDoneTapped:(UIButton *)sender {
    [_delegate getCellForDoneUpdate:self];
}

- (void)setUpDoneButtonWithSelection:(BOOL)selected {
    if (!selected) {
        _doneButton.layer.backgroundColor = [[UIColor grayColor] CGColor];
    } else {
        _doneButton.layer.backgroundColor = [[UIColor blueColor] CGColor];
    }
}
@end
