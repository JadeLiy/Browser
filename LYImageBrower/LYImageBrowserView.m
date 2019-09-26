//
//  LYImageBrowserView.m
//  LYImageBrowser
//
//  Created by Jade on 2019/9/18.
//  Copyright © 2019 Jade. All rights reserved.
//

#import "LYImageBrowserView.h"
#import "LYImageBrowerItemCell.h"

#define LYBrowserViewHeight [UIScreen mainScreen].bounds.size.height
#define LYBrowserViewWidth [UIScreen mainScreen].bounds.size.width
@interface LYImageBrowserView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UILabel *pageNumLab;
@property (nonatomic, strong) UIButton *loadBtn;
// 预览下标
@property (nonatomic, assign) NSInteger selIndex;

@end

@implementation LYImageBrowserView

+ (instancetype)browserView:(NSArray *)images selIndex:(NSInteger)selIndex {
    LYImageBrowserView *browserView = [[LYImageBrowserView alloc] initWithFrame:CGRectMake(0, 0, LYBrowserViewWidth, LYBrowserViewHeight) images:images selectIndex:selIndex];
    return browserView;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images selectIndex:(NSInteger)selectIndex {
    self = [super initWithFrame:frame];
    if (self) {
        self.selIndex = selectIndex;
        self.dataSource = images.mutableCopy;
        [self initBaseUI];
    }
    return self;
}

- (void)initBaseUI {
    // flow
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    // cv
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    cv.delegate = self;
    cv.dataSource = self;
    cv.pagingEnabled = YES;
    cv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [cv registerClass:[LYImageBrowerItemCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self addSubview:cv];
    // page
    UILabel *pageLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-80, 40, 60, 30)];
    pageLab.backgroundColor = [UIColor blackColor];
    pageLab.textColor = [UIColor whiteColor];
    pageLab.layer.cornerRadius = 15;
    pageLab.clipsToBounds = YES;
    pageLab.textAlignment = NSTextAlignmentCenter;
    self.pageNumLab = pageLab;
    [self addSubview:pageLab];
    
//    UIButton *loadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    loadBtn.frame = CGRectMake(self.frame.size.width-80, self.frame.size.height-50, 60, 30);
//    [loadBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [loadBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    self.loadBtn = loadBtn;
//    [self addSubview:loadBtn];
//
//    if (self.selIndex < self.dataSource.count) {
//        [cv scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//    }
}

- (void)click:(UIButton *)btn {
    NSLog(@"点击");
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYImageBrowerItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    [cell setupImage:self.dataSource[indexPath.item]];
    __weak LYImageBrowserView *weakView = self;
    cell.singleTap = ^{
        [weakView removeFromSuperview];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.pageNumLab.text = [NSString stringWithFormat:@"%ld/%ld",indexPath.row+1,self.dataSource.count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self removeFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    self.collectionView.scrollEnabled = ![view isKindOfClass:UISlider.class];
    return view;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
