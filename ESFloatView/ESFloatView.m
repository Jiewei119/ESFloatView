//
//  ESFloatView.m
//  ESFloatView
//
//  Created by hjw119 on 16/3/7.
//  Copyright © 2016年 hjw119. All rights reserved.
//

#import "ESFloatView.h"


@interface ESFloatView () {
    CGPoint _beginPoint;
}

@end

@implementation ESFloatView

- (id)initWithFrame:(CGRect)frame dragEnable:(BOOL)dragEnable edgeMargin:(CGFloat)edgeMargin {
    self.dragEnable = dragEnable;
    self.edgeMargin = edgeMargin;
    
    return [self initWithFrame:frame];
}

/*
 * 显示视图，如果父视图parentView == nil，则默认作为[[[UIApplication sharedApplication] delegate] window]的子视图浮动显示
 * animated 是否具有动画效果
 */
- (void)show:(BOOL)animated {
    if (self.parentView == nil) {
        UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
        self.parentView = window;
    }
    
    if (animated) {
        self.alpha = 0.0;
        [self.parentView addSubview:self];
        [self.parentView bringSubviewToFront:self];
        NSTimeInterval duration = 0.3;
        if (self.animateDuration > 0) {
            duration = self.animateDuration;
        }
        [UIView animateWithDuration:duration animations:^{
            self.alpha = 1.0;
        } completion:nil];
    }
    else {
        [self.parentView addSubview:self];
        [self.parentView bringSubviewToFront:self];
    }}

/*
 * 隐藏视图
 * animated 是否具有动画效果
 */
- (void)hide:(BOOL)animated {
    if (animated) {
        NSTimeInterval duration = 0.3;
        if (self.animateDuration > 0) {
            duration = self.animateDuration;
        }
        [UIView animateWithDuration:duration animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else {
        [self removeFromSuperview];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    _beginPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self];
    CGFloat offsetX = nowPoint.x - _beginPoint.x;
    CGFloat offsetY = nowPoint.y - _beginPoint.y;
    
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGRect rect = self.frame;
    CGFloat marginLeft = rect.origin.x;
    CGFloat marginTop = rect.origin.y;
    CGFloat marginRight = self.parentView.frame.size.width - (rect.origin.x + rect.size.width);
    CGFloat marginButtom = self.parentView.frame.size.height - (rect.origin.y + rect.size.height);
    BOOL needToAjust = NO;
    
    if (marginLeft < self.edgeMargin) {
        needToAjust = YES;
        rect.origin.x = self.edgeMargin;
    }
    if (marginTop < self.edgeMargin) {
        needToAjust = YES;
        rect.origin.y = self.edgeMargin;
    }
    if (marginRight < self.edgeMargin) {
        needToAjust = YES;
        rect.origin.x = self.parentView.frame.size.width - self.frame.size.width - self.edgeMargin;
    }
    if (marginButtom < self.edgeMargin) {
        needToAjust = YES;
        rect.origin.y = self.parentView.frame.size.height - self.frame.size.height - self.edgeMargin;
    }
    
    if (needToAjust) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = rect;
        }];
    }
}


@end
