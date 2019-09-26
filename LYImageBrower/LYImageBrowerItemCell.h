//
//  CollectionViewCell.h
//  LYImageBrowser
//
//  Created by Jade on 2019/9/18.
//  Copyright © 2019 Jade. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYImageBrowerItemCell : UICollectionViewCell

@property (nonatomic, copy) void(^singleTap)(void);

- (void)setupImage:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
