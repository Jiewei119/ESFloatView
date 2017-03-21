//
//  ViewController.m
//  ESFloatView
//
//  Created by hjw119 on 16/3/7.
//  Copyright © 2016年 hjw119. All rights reserved.
//

#import "ViewController.h"
#import "ESFloatView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.floatView == nil) {
        self.floatView = [[ESFloatView alloc] initWithFrame:CGRectMake(20, 84, 100, 128) dragEnable:YES edgeMargin:20];
        self.floatView.center = self.view.center;
        self.floatView.backgroundColor = [UIColor redColor];
        //self.floatView.parentView = self.view;
        self.floatView.animateDuration = 3;
        [self.floatView show:YES];
        self.isShowFloatView = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSwitch:(id)sender {
    if (self.floatView != nil) {
        if (!self.isShowFloatView) {
            [self.floatView show:YES];
            self.isShowFloatView = YES;
        }
        else {
            self.isShowFloatView = NO;
            [self.floatView hide:YES];
        }
    }
}

- (IBAction)onNext:(id)sender {
    UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
