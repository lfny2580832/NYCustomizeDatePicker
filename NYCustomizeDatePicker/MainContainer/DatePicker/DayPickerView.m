//
//  DayPickerView.m
//  BOEFace
//
//  Created by 牛严 on 15/7/13.
//  Copyright (c) 2015年 缪宇青. All rights reserved.
//

#import "DayPickerView.h"
#define kMainProjColor      [UIColor colorWithRed:251.f/255 green:73.f/255 blue:14.f/255 alpha:1.0f]

@interface DayPickerView ()
@property(strong,nonatomic)NSCalendar *calendar;
@property(strong,nonatomic)NSDate *chosenDate;
@property NSInteger chosenYear;
@property NSInteger chosenMonth;
@property NSInteger chosenDay;
@property(strong,nonatomic)NSDateComponents *components;
@property(strong,nonatomic)NSDateComponents *finalComponents;
@end

@implementation DayPickerView

#pragma mark - Private Methods
-(void)loadWithChosenDate:(NSDate *)date{
    self.chosenDate = date;
    [self loadDate];
    self.delegate = self;
    self.dataSource = self;
    [self selectRow:self.chosenDay -1  inComponent:0 animated:NO];
}

-(void)loadDate{
    self.calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth  |  NSCalendarUnitDay;
    NSDateComponents *chosencomponents = [self.calendar components:unitFlags fromDate:self.chosenDate];
    self.chosenYear = [chosencomponents year];  //选择的年份
    self.chosenMonth = [chosencomponents month];  //选择的月份
    self.chosenDay = [chosencomponents day];  // 选择的号数
    self.finalComponents = [self.calendar components:unitFlags fromDate:self.chosenDate];
    [self.finalComponents setYear:self.chosenYear];
    [self.finalComponents setMonth:self.chosenMonth];
    [self.finalComponents setDay:self.chosenDay];
}

#pragma mark Notification Methods
- (void)yearValueChangedWithNotification:(NSNotification *)notification{
    self.chosenYear = [notification.object intValue];
    [self.finalComponents setYear:self.chosenYear];
    NSDate *finalYearDate = [self.calendar dateFromComponents:self.finalComponents];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FinalYearDate" object:finalYearDate];
    [self reloadAllComponents];
}

- (void)monthValueChangedWithNotification:(NSNotification *)notification{
    self.chosenMonth = [notification.object intValue];
    [self.finalComponents setMonth:self.chosenMonth];
    NSDate *finalMonthDate = [self.calendar dateFromComponents:self.finalComponents];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FinalMonthDate" object:finalMonthDate];
    [self reloadAllComponents];
}

#pragma mark - UIView Methods
-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(yearValueChangedWithNotification:) name:@"YearValueChanged" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(monthValueChangedWithNotification:) name:@"MonthValueChanged" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - UIPickerView DataSource Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //返回
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ((self.chosenMonth == 1) || (self.chosenMonth == 3) || (self.chosenMonth == 5) ||(self.chosenMonth == 7)||(self.chosenMonth == 8)||(self.chosenMonth == 10)||(self.chosenMonth == 12))
    {
        return 31;
    }
    if ((self.chosenMonth == 4)||(self.chosenMonth == 6)||(self.chosenMonth == 9)||(self.chosenMonth == 11)) {
        return 30;
    }
    if ((self.chosenYear % 100 != 0)&(self.chosenYear % 4 == 0)) {
        return 29;
    }
    if ((self.chosenYear % 400 == 0)) {
        return 29;
    }
    return 28;
}

#pragma mark - UIPickerView Delegate Methods
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view{
    UILabel *dateLabel = (UILabel *)view;
    dateLabel = [[UILabel alloc] init];
    [dateLabel setTextColor:kMainProjColor];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    NSString *currentDay = [NSString stringWithFormat:@"%lu日", row + 1 ];
    [dateLabel setText:currentDay];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    return dateLabel;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 50;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.chosenDay = row + 1;
    [self.finalComponents setDay:self.chosenDay];
    NSDate *finalDayDate = [self.calendar dateFromComponents:self.finalComponents];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FinalDayDate" object:finalDayDate];
}

@end
