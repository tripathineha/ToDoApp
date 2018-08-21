//
//  NSDate+LocalizedDate.h
//  ToDoApp
//
//  Created by GlobalLogic on 17/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LocalizedDate)

@property (nonatomic,readonly) NSString *localizedString;

- (NSDateComponents *)getDateComponents;

@end
