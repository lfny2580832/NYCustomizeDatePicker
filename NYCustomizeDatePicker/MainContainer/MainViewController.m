//
//  MainViewController.m
//  NYCustomizeDatePicker
//
//  Created by 牛严 on 15/9/26.
//  Copyright (c) 2015年 牛严. All rights reserved.
//

#import "MainViewController.h"
#import "PickerControllView.h"

@interface MainViewController ()<DatePickerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) PickerControllView *pickerVC;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showDatePicker:(id)sender {
    self.pickerVC = [[[NSBundle mainBundle]loadNibNamed:@"PickerControllView" owner:self options:nil]lastObject];
    [self.view addSubview:self.pickerVC];
    self.pickerVC.pickerDelegate = self;
}

#pragma mark DatePicker Delegate
-(void)datePickerRemove{
    [self.pickerVC removeFromSuperview];
}

-(void)datePickerReturn:(NSString *)dateString{
    self.dateLabel.text = dateString;
}
@end
