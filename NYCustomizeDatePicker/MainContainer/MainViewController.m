//
//  MainViewController.m
//  NYCustomizeDatePicker
//
//  Created by 牛严 on 15/9/24.
//  Copyright (c) 2015年 牛严. All rights reserved.
//

#import "MainViewController.h"
#import "SelectDateView.h"

#define ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define ScreenHeight         [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()
@property(strong,nonatomic)SelectDateView *selectDateView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property(strong,nonatomic)NSCalendar *calendar;
@property(strong,nonatomic)NSDateFormatter *dateFormatter;
@property(strong,nonatomic)NSDate *chosenDate;
@property(strong,nonatomic)UIView *background;
@property CGFloat dvWidth;
@property CGFloat dvHeight;
@end

@implementation MainViewController


#pragma mark - Initialize Methods
- (UIView *)background
{
    if (!_background) {
        _background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [UIScreen mainScreen].bounds.size.height)];
        _background.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(removeSubViews)];
        singleTap.numberOfTapsRequired = 1;
        [_background addGestureRecognizer:singleTap];
    }
    return _background;
}

#pragma mark - Private Methods
-(void)loadSelectDateView{
    self.dvWidth = ScreenWidth;
    self.selectDateView = [[[NSBundle mainBundle]loadNibNamed:@"SelectDateView" owner:self options:nil]lastObject];
    [self.selectDateView loadWithChooseDate:self.chosenDate];
    self.dvHeight = self.selectDateView.frame.size.height;
        
    CGRect frame = self.selectDateView.frame;
    frame.origin.x = 0.f;
    frame.origin.y = ScreenHeight ;
    frame.size.width = self.dvWidth;
    frame.size.width = self.dvHeight;
    [self.selectDateView setFrame:frame];
    [self.selectDateView.cancelButton addTarget:self
                                         action:@selector(cancelButton)
                                        forControlEvents:UIControlEventTouchUpInside];
    [self.selectDateView.doneButton addTarget:self
                                       action:@selector(doneButton)
                                      forControlEvents:UIControlEventTouchUpInside];
}

-(void)loadDate{
    self.calendar = [NSCalendar currentCalendar];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.chosenDate = [NSDate date];
    NSString *chosenDateString = [self.dateFormatter stringFromDate:self.chosenDate];
    self.dateLabel.text = chosenDateString;
}

#pragma mark - UIView Methods
-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadDate];
}

#pragma mark - IBAction Methods
- (IBAction)showCustomeDatePicker:(id)sender {
    [self.background setBackgroundColor:[UIColor clearColor]];
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.background setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5]];
                     }];
    [self loadSelectDateView];
    [self.view addSubview:self.background];
    [self.view addSubview:self.selectDateView];
    [UIView animateWithDuration:0.2 animations:^{
        [self.selectDateView setFrame:CGRectMake(0, ScreenHeight - self.dvHeight, self.dvWidth, self.dvHeight)];
    }];
}

-(void)cancelButton{
    [self removeSubViews];
}

-(void)doneButton{
    self.chosenDate = self.selectDateView.chosenDate;
    NSString *finalDateString = [self.dateFormatter stringFromDate:self.chosenDate];
    self.dateLabel.text = finalDateString;
    [self removeSubViews];
}

-(void)removeSubViews{
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.background setBackgroundColor:[UIColor clearColor]];
                     }completion:^(BOOL finished){
                         [self.background removeFromSuperview];
                     }];
    [UIView animateWithDuration:0.2
                     animations:^{
                             [self.selectDateView setFrame:CGRectMake(0, ScreenHeight, self.dvWidth, self.dvHeight)];
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                                 [self.selectDateView removeFromSuperview];
                                 self.selectDateView = nil;
                         }
                     }];
}

@end
