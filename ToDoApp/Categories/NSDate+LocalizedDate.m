//
//  NSDate+LocalizedDate.m
//  ToDoApp
//
//  Created by GlobalLogic on 17/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "NSDate+LocalizedDate.h"

@implementation NSDate (LocalizedDate)

- (NSString *)localizedString {
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    return dateString;
}

- (NSDateComponents *)getDateComponents {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    return [calendar components:NSCalendarUnitDay
            | NSCalendarUnitMonth
            | NSCalendarUnitYear
            | NSCalendarUnitMinute
            | NSCalendarUnitHour
            | NSCalendarUnitSecond
                       fromDate:self];
}

@end
