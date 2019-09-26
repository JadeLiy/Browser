//
//  LYImageBrowerItemCell.m
//  LYImageBrowser
//
//  Created by Jade on 2019/9/18.
//  Copyright © 2019 Jade. All rights reserved.
//

#import "LYImageBrowerItemCell.h"

@interface LYImageBrowerItemCell ()<UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *sc;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat imageNormalWidth;
@property (nonatomic, assign) CGFloat imageNormalHeight;

@end

@implementation LYImageBrowerItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseUI];
    }
    return self;
}

- (void)initBaseUI {
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    sc.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    sc.delegate = self;
    self.sc = sc;
    // 设置f放大倍数和代理
    self.sc.minimumZoomScale = 1;
    self.sc.maximumZoomScale = 3;
    
    [self.contentView addSubview:sc];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.userInteractionEnabled = YES;
    self.imageView = imageView;
    [sc addSubview:imageView];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGrEvent)];
    [self.sc addGestureRecognizer:tapGR];
}

- (void)tapGrEvent {
    if (self.singleTap) {
        self.singleTap();
    }
}

- (void)setupImage:(NSString *)image {
    
    CGSize imageSize = [UIImage imageNamed:image].size;
    CGFloat mainScale = ScreenWidth*1.0/ScreenHeight;
    CGFloat subScale =  imageSize.width*1.0/imageSize.height;
    NSLog(@"%f,%f",mainScale, subScale);
    if (subScale>mainScale) {
        CGFloat scale = imageSize.width*1.0/ScreenWidth;
        CGFloat height = imageSize.height/scale;
        self.imageView.frame = CGRectMake(0, (ScreenHeight-height)*0.5, ScreenWidth, height);
    } else {
        CGFloat scale = imageSize.height*1.0/ScreenHeight;
        CGFloat width = imageSize.width/scale;
        self.imageView.frame = CGRectMake((ScreenWidth-width)*0.5, 0, width, ScreenHeight);
    }
    self.imageView.image = [UIImage imageNamed:image];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
//    NSLog(@"开始缩放");
//}
//
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
//    NSLog(@"结束缩放");
//}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 缩放中
    CGRect frame = self.imageView.frame;
    frame.origin.y = (self.sc.frame.size.height - self.imageView.frame.size.height) > 0 ? (self.sc.frame.size.height - self.imageView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.sc.frame.size.width - self.imageView.frame.size.width) > 0 ? (self.sc.frame.size.width - self.imageView.frame.size.width) * 0.5 : 0;
    self.imageView.frame = frame;
    
    self.sc.contentSize = CGSizeMake(self.imageView.frame.size.width + 30, self.imageView.frame.size.height + 30);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了");
}

@end
