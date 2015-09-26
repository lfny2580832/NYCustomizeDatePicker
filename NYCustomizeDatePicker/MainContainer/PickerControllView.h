//
//  MainViewController.h
//  NYCustomizeDatePicker
//
//  Created by 牛严 on 15/9/24.
//  Copyright (c) 2015年 牛严. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate ;
@interface PickerControllView : UIView
@property (assign, nonatomic) id<DatePickerDelegate> pickerDelegate;

- (void)showCustomeDatePicker;
@end

@protocol DatePickerDelegate <NSObject>

-(void)datePickerRemove;

@end
