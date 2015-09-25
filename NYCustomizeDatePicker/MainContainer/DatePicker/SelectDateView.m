//
//  SelectDateView.m
//  BOEFace
//
//  Created by 牛严 on 15/7/13.
//  Copyright (c) 2015年 缪宇青. All rights reserved.
//

#import "SelectDateView.h"
#import "YearPickerView.h"
#import "MonthPickerView.h"
#import "DayPickerView.h"
#import "PickerSubView.h"

#define kSubViewGap 0.0f
#define ScreenWidth         [UIScreen mainScreen].bounds.size.width

@interface SelectDateView ()
@end

@implementation SelectDateView

#pragma mark - Initialize Methods
-(void)loadPickerSubViews{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[PickerSubView class]]) {
            [subView removeFromSuperview];
        }
    }
    NSMutableArray  *subViewArray = [[NSMutableArray alloc]initWithObjects:@"YearPickerView", @"MonthPickerView",@"DayPickerView", nil];
    //加载每个子模块
    for (NSString *classString in subViewArray) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:classString owner:self options:nil];
        PickerSubView *pickerSubView = [nibs lastObject];
        CGRect rect = pickerSubView.frame;
        CGFloat dpvWidth = (ScreenWidth - kSubViewGap * 2)/3;
        if ([pickerSubView isKindOfClass:[YearPickerView class]]) {
            YearPickerView *ypv = (YearPickerView *)pickerSubView;
            [ypv loadWithChosenDate:self.chosenDate];
            rect = ypv.frame;
            rect.origin.x = 0.f;
            rect.origin.y = 0.f;
            rect.size.width = dpvWidth;
        }
        else if ([pickerSubView isKindOfClass:[MonthPickerView class]]) {
            MonthPickerView *mpv = (MonthPickerView *)pickerSubView;
            [mpv loadWithChosenDate:self.chosenDate];
            rect = mpv.frame;
            rect.origin.x = dpvWidth + kSubViewGap;
        }
        else if ([pickerSubView isKindOfClass:[DayPickerView class]]){
            DayPickerView *dpv = (DayPickerView *)pickerSubView;
            [dpv loadWithChosenDate:self.chosenDate];
            rect = dpv.frame;
            rect.origin.x = (dpvWidth + kSubViewGap)*2;
        }
        pickerSubView.frame = rect;
        [self.view addSubview:pickerSubView];
    }
}

#pragma mark - Private Methods
-(void)loadWithChooseDate:(NSDate *)date{
    self.chosenDate = date;
    [self loadPickerSubViews];
}

#pragma mark Notification Methods
-(void)finalYearDateWithNotification:(NSNotification *)notification{
    self.chosenDate = notification.object;
}

-(void)finalMonthDateWithNotification:(NSNotification *)notification{
    self.chosenDate = notification.object;
}

-(void)finalDayDateWithNotification:(NSNotification *)notification{
    self.chosenDate = notification.object;
}

#pragma mark - UIView Methods
-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finalYearDateWithNotification:) name:@"FinalYearDate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finalMonthDateWithNotification:) name:@"FinalMonthDate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finalDayDateWithNotification:) name:@"FinalDayDate" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
