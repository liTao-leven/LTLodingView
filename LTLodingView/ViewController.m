//
//  ViewController.m
//  LTLodingView
//
//  Created by 李涛 on 16/9/2.
//  Copyright © 2016年 李涛. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LT_loding.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *animationViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//默认
- (IBAction)loding1:(UIView*)sender {
    [sender lt_starAnimationDuration:0.5];
    [self endAnimation:sender];
    
}
//编辑默认
- (IBAction)loding2:(UIView*)sender {
    [sender lt_starAnimationDuration:0.5 activityIndicatorBlock:^(UIActivityIndicatorView *acitivityView) {
        [acitivityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }];
    [self endAnimation:sender];
}

//本地gif
- (IBAction)loding3:(UIView*)sender {
    [sender lt_starAnimationDuration:0.5 withName:@"loding"];
    [self endAnimation:sender];
}

//网络图片
- (IBAction)loding4:(UIView*)sender {
    [sender lt_starAnimationDuration:0.5 withUrl:@"http://cdn.uehtml.com/201402/1392662616656_1140x0.gif"];
    [self endAnimation:sender];
    
    
}

//旋转图片
- (IBAction)loding5:(UIButton *)sender {
    UIImageView* view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loding.gif"]];
    view.layer.cornerRadius = sender.bounds.size.width/2;
    [view setClipsToBounds:YES];
    [sender lt_starAnimationDuration:0.5 View:view velocity:1];
    [self endAnimation:sender];
}



//结束动画
- (void)endAnimation:(UIView*)sender{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender lt_endAnimationDuration:0.3];
    });
}
@end
