//
//  YearPickerView.h
//  BOEFace
//
//  Created by 牛严 on 15/7/13.
//  Copyright (c) 2015年 缪宇青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerSubView.h"

@protocol YearPickerDelegate;

@interface YearPickerView : PickerSubView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (assign, nonatomic) id<YearPickerDelegate> yearDelegate;
@end

@protocol YearPickerDelegate <NSObject>

- (void)yearValueChanged:(NSString *)year;

@end