//
//  LYImageBrowserView.h
//  LYImageBrowser
//
//  Created by Jade on 2019/9/18.
//  Copyright © 2019 Jade. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYImageBrowserView : UIView

/** 实例方法 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images selectIndex:(NSInteger)selectIndex;
/** 工厂方法 */
+ (instancetype)browserView:(NSArray *)images selIndex:(NSInteger)selIndex;
@end

NS_ASSUME_NONNULL_END
