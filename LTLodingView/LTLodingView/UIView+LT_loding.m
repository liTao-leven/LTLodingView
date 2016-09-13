//
//  UIView+LT_loding.m
//  Yue
//
//  Created by 李涛 on 16/8/31.
//  Copyright © 2016年 李涛. All rights reserved.
//

#import "UIView+LT_loding.h"
#import <objc/runtime.h>
#import "UIImageView+LT_loding.h"
@implementation UIView (LT_loding)
static char* LT_BgViewKey = "bgViewKey";
static char* LT_BgColor = "bgColor";
static char* LT_Size = "size";
static char* LT_Radius = "radius";


-(void)lt_starAnimationDuration:(NSTimeInterval)duration{
    [self lt_starAnimationDuration:duration activityIndicatorBlock:nil];
}

-(void)lt_starAnimationDuration:(NSTimeInterval)duration loadingBlock:(void(^)(UIView* bgView))loadingBlock{
    self.hidden    = YES;
    CGRect rect    = self.frame;
    CGPoint point  = self.center;

    UIView* bgView = [[UIView alloc]initWithFrame:self.frame];
    self.bgView    = bgView;
    
    [self.superview insertSubview:bgView aboveSubview:self];
    if (self.bgColor) {
        bgView.backgroundColor = self.bgColor;
    }
    else{
        bgView.backgroundColor = self.backgroundColor;
    }
    
    float width = rect.size.width > rect.size.height ? rect.size.height : rect.size.width;
    [UIView animateWithDuration:duration animations:^{
        
        
        bgView.frame = CGRectMake(0, 0, width, width);
        if (self.lt_size.width > 0) {
            bgView.frame = CGRectMake(0, 0, self.lt_size.width, self.lt_size.height);
        }
        bgView.center = point;
        bgView.layer.cornerRadius = width/2;
        if (self.lt_cornerRadius > 0) {
            bgView.layer.cornerRadius = self.lt_cornerRadius;
        }
    } completion:^(BOOL finished) {
        if (loadingBlock) {
            loadingBlock(bgView);
        }
    }];
}


-(void)lt_starAnimationDuration:(NSTimeInterval)duration activityIndicatorBlock:(void (^)(UIActivityIndicatorView* acitivityView))activityIndicatorBlock{
    
    [self lt_starAnimationDuration:duration loadingBlock:^(UIView *bgView) {
        UIActivityIndicatorView* acitivityView = [[UIActivityIndicatorView alloc]initWithFrame:bgView.bounds];
        [bgView addSubview:acitivityView];
        if (activityIndicatorBlock) {
            activityIndicatorBlock(acitivityView);
        }
        [acitivityView startAnimating];
    }];
}


-(void)lt_starAnimationDuration:(NSTimeInterval)duration View:(UIView*)view velocity:(CGFloat)velocity{
    [self lt_starAnimationDuration:duration View:view animation:^(UIView *bgView, UIView *view) {

        [UIView animateWithDuration:velocity delay:0 options:UIViewAnimationOptionRepeat animations:^{
            view.transform = CGAffineTransformMakeRotation(2 * M_PI);
        } completion:^(BOOL finished) {
            
        }];
        [view.layer addAnimation:[self rotation:velocity] forKey:nil];
    }];
}




-(void)lt_starAnimationDuration:(NSTimeInterval)duration View:(UIView*)view animation:(void (^)(UIView* bgView, UIView* view))animation{
    [self lt_starAnimationDuration:duration loadingBlock:^(UIView *bgView) {
        view.frame = bgView.bounds;
        [bgView addSubview:view];
        if (animation) {
            animation(bgView,view);
        }
    }];
}

-(void)lt_starAnimationDuration:(NSTimeInterval)duration withUrl:(NSString*)url{
    UIImageView* imageView = [[UIImageView alloc]init];
    [imageView lt_setImageWithUrl:url];
    [self lt_starAnimationDuration:duration View:imageView velocity:0];
}

-(void)lt_starAnimationDuration:(NSTimeInterval)duration withName:(NSString*)name{
    UIImageView* imageView = [[UIImageView alloc]init];
    [imageView lt_setImageWithName:name];
    if (self.lt_size.width == 0) {
        UIImage* img = imageView.image;
        float proportion = img.size.width/img.size.height;
        CGSize size = CGSizeMake(self.frame.size.height * proportion, self.frame.size.height);
        self.lt_size = size;
    }
    [self lt_starAnimationDuration:duration View:imageView velocity:0];
}



-(void)lt_endAnimationDuration:(NSTimeInterval)duration{
    CGPoint point = self.center;
    [self.bgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    self.hidden = NO;
    self.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        self.bgView.frame       = self.frame;
        self.bgView.center      = point;
        self.layer.cornerRadius = self.layer.cornerRadius;
        self.bgView.alpha       = 0;
        self.alpha              = 1;
        
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.hidden = NO;
    }];
}







-(void)setBgView:(UIView *)bgView{
    objc_setAssociatedObject(self, &LT_BgViewKey, bgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)bgView{
    return objc_getAssociatedObject(self, &LT_BgViewKey);
}
-(void)setBgColor:(UIColor *)bgColor{
    objc_setAssociatedObject(self, &LT_BgColor, bgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIColor *)bgColor{
    return objc_getAssociatedObject(self, &LT_BgColor);
}
-(void)setLt_size:(CGSize)lt_size{
    objc_setAssociatedObject(self, &LT_Size, [NSValue valueWithCGSize:lt_size], OBJC_ASSOCIATION_RETAIN);
}
-(CGSize)lt_size{
    NSValue* value = objc_getAssociatedObject(self, &LT_Size);
    return [value CGSizeValue];
}
-(void)setLt_cornerRadius:(CGFloat)lt_cornerRadius{
    objc_setAssociatedObject(self, &LT_Radius, @(lt_cornerRadius), OBJC_ASSOCIATION_RETAIN);
}
-(CGFloat)lt_cornerRadius{
    NSNumber* radius = objc_getAssociatedObject(self, &LT_Radius);
    return radius.floatValue;
}

#pragma mark ====旋转动画======
-(CABasicAnimation *)rotation:(float)dur
{
    if (dur <= 0) {
        return nil;
    }
    //设置动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation                     = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue             = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration            = dur;
    rotationAnimation.cumulative          = YES;
    rotationAnimation.repeatCount         = 1000000;
    rotationAnimation.removedOnCompletion = NO;
    return rotationAnimation;
}

@end
