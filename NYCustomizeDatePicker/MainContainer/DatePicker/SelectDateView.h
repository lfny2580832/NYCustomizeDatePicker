//
//  SelectDateView.h
//  BOEFace
//
//  Created by 牛严 on 15/7/13.
//  Copyright (c) 2015年 缪宇青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDateView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIView *view;
@property(strong,nonatomic)NSDate *chosenDate;

-(void)loadWithChooseDate:(NSDate *)date;

@end
