//
//  YearPickerView.m
//  BOEFace
//
//  Created by 牛严 on 15/7/13.
//  Copyright (c) 2015年 缪宇青. All rights reserved.
//

#import "YearPickerView.h"
@interface YearPickerView ()
@property(strong,nonatomic)NSCalendar *calendar;
@property(strong,nonatomic)NSDate *selectDate;
@property(strong,nonatomic)NSDate *startDate;
@property(strong,nonatomic)NSDate *endDate;
@property(strong,nonatomic)NSDate *chosenDate;
@property(strong,nonatomic)NSDateComponents *startCpts;
@property(strong,nonatomic)NSDateComponents *endCpts;
@property NSInteger startYear;
@property NSInteger chosenYear;
@property NSInteger years;
@end

@implementation YearPickerView

#pragma mark - Private Methods
-(void)loadDate{
    self.calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.startDate = [dateFormatter dateFromString:@"1900-01-01"];
    self.endDate = [dateFormatter dateFromString:@"2030-12-30"];
    self.startCpts = [self.calendar components:NSCalendarUnitYear
                                      fromDate:self.startDate];
    self.endCpts = [self.calendar components:NSCalendarUnitYear fromDate:self.endDate];
    [dateFormatter setDateFormat:@"yyyy"];
    self.startYear = [[dateFormatter stringFromDate:self.startDate]intValue];
    self.chosenYear = [[dateFormatter stringFromDate:self.chosenDate]intValue];
}

-(void)loadWithChosenDate:(NSDate *)Date{
    self.chosenDate = Date;
    [self loadDate];
    self.delegate = self;
    self.dataSource = self;
    NSInteger gapYears = self.chosenYear - self.startYear;
    [self selectRow:gapYears inComponent:0 animated:NO];
    [self reloadAllComponents];
}

#pragma mark - UIView Methods
-(void)awakeFromNib{
    [super awakeFromNib];
}

#pragma mark - UIPickerView DataSource Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    self.years = [self.endCpts year] - [self.startCpts year] + 1;
    return self.years;
}

#pragma mark - UIPickerView Delegate Methods
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view{
    UILabel *dateLabel = (UILabel *)view;
    dateLabel = [[UILabel alloc] init];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear
                                                    fromDate:self.startDate];
    NSString *currentYear = [NSString stringWithFormat:@"%ld年", [components year] + row];
    [dateLabel setText:currentYear];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    return dateLabel;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 70;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSDateComponents *indicatorComponents = [self.calendar components:NSCalendarUnitYear
                                                             fromDate:self.startDate];
    NSInteger year = [indicatorComponents year] + row;
    NSString *chosenYearString = [NSString stringWithFormat:@"%ld",(long)year];
    [self.yearDelegate yearValueChanged:chosenYearString];
}

@end
