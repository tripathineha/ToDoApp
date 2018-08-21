//
//  UIView+RoundedView.m
//  ToDoApp
//
//  Created by GlobalLogic on 14/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "UIView+RoundedView.h"

@implementation UIView (RoundedView)

- (CGFloat)cornerRadius {
    return self.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth {
    return self.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor {
    return self.borderColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

@end
