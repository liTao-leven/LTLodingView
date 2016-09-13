//
//  UIView+LT_loding.h
//  Yue
//
//  Created by 李涛 on 16/8/31.
//  Copyright © 2016年 李涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LT_loding)
@property (nonatomic,strong) UIView  * bgView;
@property (nonatomic,strong) UIColor * bgColor;//背景颜色
@property (nonatomic,assign) CGSize  lt_size;//自定义大小
@property (nonatomic,assign) CGFloat lt_cornerRadius;//自定义圆角半径
//@property(nonatomic,strong)void (^activityIndicatorBlock)(UIActivityIndicatorView*);

/**
 *  默认动画
 *
 *  @param duration view从原来形状变化为圆形所需时间
 */
-(void)lt_starAnimationDuration:(NSTimeInterval)duration;

/**
 *  默认结束动画
 *
 *  @param duration view从圆形还原为原来形状的时间
 */
-(void)lt_endAnimationDuration:(NSTimeInterval)duration;

/**
 *  可设置自定义view自定义速度的旋转动画
 *
 *  @param duration view从原来形状变化为圆形所需时间
 *  @param view     设置自定义的view
 *  @param velocity 旋转一周所需的时间(如果不需要旋转,可以设置为0)
 */
-(void)lt_starAnimationDuration:(NSTimeInterval)duration View:(UIView*)view velocity:(CGFloat)velocity;

/**
 *  变形动画结束时的回调
 *
 *  @param duration     view从原来形状变化为圆形所需时间
 *  @param loadingBlock 变形动画结束时回调 bgView为变形后的view(非变形前的view)
 */
-(void)lt_starAnimationDuration:(NSTimeInterval)duration loadingBlock:(void(^)(UIView* bgView))loadingBlock;

/**
 *  变形动画结束时的回调,可在block里修改默认动画的动画样式
 *
 *  @param duration               view从原来形状变化为圆形所需时间
 *  @param activityIndicatorBlock 变形动画结束时回调 可修改acitivityView来改变默认动画的效果
 */
-(void)lt_starAnimationDuration:(NSTimeInterval)duration activityIndicatorBlock:(void (^)(UIActivityIndicatorView* acitivityView))activityIndicatorBlock;

/**
 *  变形动画结束时的回调 这里可以高度个性化的定义自己的动画效果
 *
 *  @param duration  view从原来形状变化为圆形所需时间
 *  @param view      自定义的view
 *  @param animation bgView为变形后的view(非变形前的view) view为自定义的view
 */
-(void)lt_starAnimationDuration:(NSTimeInterval)duration View:(UIView*)view animation:(void (^)(UIView* bgView, UIView* view))animation;

/**
 *  通过url加载gif图片来设置loding效果
 *
 *  @param duration view从原来形状变化为圆形所需时间
 *  @param url      gif图片地址
 */
-(void)lt_starAnimationDuration:(NSTimeInterval)duration withUrl:(NSString*)url;

/**
 *  通过包里的gif图片来设置loding效果
 *
 *  @param duration view从原来形状变化为圆形所需时间
 *  @param name     gif图片名称
 */
-(void)lt_starAnimationDuration:(NSTimeInterval)duration withName:(NSString*)name;
@end

