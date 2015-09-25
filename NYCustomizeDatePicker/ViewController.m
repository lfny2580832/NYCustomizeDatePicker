//
//  ViewController.m
//  NYCustomizeDatePicker
//
//  Created by 牛严 on 15/9/24.
//  Copyright (c) 2015年 牛严. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showButtonClicked:(id)sender {
    MainViewController *vc = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
