//
//  UIView+RoundedView.h
//  ToDoApp
//
//  Created by GlobalLogic on 14/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundedView)

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic, copy) IBInspectable UIColor *borderColor;

@end
