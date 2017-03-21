//
//  ESFloatView.h
//  ESFloatView
//
//  Created by hjw119 on 16/3/7.
//  Copyright © 2016年 hjw119. All rights reserved.
//

#import <UIKit/UIKit.h>
//浮动视图
@interface ESFloatView : UIView

@property (nonatomic) BOOL dragEnable;  //是否可拖动
@property (nonatomic) CGFloat edgeMargin;  //距离边缘的空白间隔
@property (strong,nonatomic) UIView* parentView;  //父视图;
@property (nonatomic) NSTimeInterval animateDuration;  //动画时长

/*
 * 初始化视图
 * dragEnable 是否可以拖动
 * edgeMargin 距离边缘的空白间隔
 */
- (id)initWithFrame:(CGRect)frame dragEnable:(BOOL)dragEnable edgeMargin:(CGFloat)edgeMargin;

/*
 * 显示视图，如果父视图parentView == nil，则默认作为[[[UIApplication sharedApplication] delegate] window]的子视图浮动显示
 * animated 是否具有动画效果
 */
- (void)show:(BOOL)animated;

/*
 * 隐藏视图
 * animated 是否具有动画效果
 */
- (void)hide:(BOOL)animated;

@end
