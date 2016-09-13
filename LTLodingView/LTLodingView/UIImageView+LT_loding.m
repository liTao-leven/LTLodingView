//
//  UIImageView+LT_loding.m
//  Yue
//
//  Created by 李涛 on 16/9/2.
//  Copyright © 2016年 李涛. All rights reserved.
//

#import "UIImageView+LT_loding.h"
#import "UIImage+LT_git.h"

@implementation UIImageView (LT_loding)
-(void)getImageFromURL:(NSString *)fileURL callBack:(void(^)(UIImage* image))callBack{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        UIImage * result;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        result = [UIImage lt_animatedGIFWithData:data];
        if (callBack) {
            callBack(result);
        }

    });
}

- (void)lt_setImageWithUrl:(NSString*)url{
    [self getImageFromURL:url callBack:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
        
    }];
}

- (void)lt_setImageWithName:(NSString*)name{
    self.image = [UIImage lt_animatedGIFNamed:name];
}
@end
