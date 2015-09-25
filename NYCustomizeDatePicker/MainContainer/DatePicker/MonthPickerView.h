//
//  MonthPickerView.h
//  BOEFace
//
//  Created by 牛严 on 15/7/13.
//  Copyright (c) 2015年 缪宇青. All rights reserved.
//

#import "PickerSubView.h"

@protocol MonthPickerDelegate;

@interface MonthPickerView : PickerSubView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) id<MonthPickerDelegate> monthDelegate;

@end

@protocol MonthPickerDelegate <NSObject>

- (void)monthValueChanged:(NSString *)month;

@end
