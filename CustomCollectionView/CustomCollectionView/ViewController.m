//
//  ViewController.m
//  CustomCollectionView
//
//  Created by miss on 16/11/24.
//  Copyright © 2016年 mukr. All rights reserved.
//


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "HACollectionViewCell.h"
#import "HACollectionViewFlowLayout.h"
#import "HACollectionContanst.h"
#import "NextViewController.h"
#import "FirstTransition.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HACollectionViewFlowLayoutDelegate,UINavigationControllerDelegate>
{
    CGFloat collectionVHeight;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    collectionVHeight = 300*SCREEN_HEIGHT/667;

    _collectionView.center = self.view.center;
    _collectionView.bounds = CGRectMake(0, 0, SCREEN_WIDTH, collectionVHeight+30);
    
    HACollectionViewFlowLayout *flow = [[HACollectionViewFlowLayout alloc]init];
    
    //1.1.布局item,设置item的大小
    //放大后的item会放大HAZoomScale倍  所以此处需计算
    flow.itemSize = CGSizeMake(collectionVHeight / HAZoomScale * HAImageScale, collectionVHeight / HAZoomScale);
    flow.isAlpha = YES;
    flow.delegate = self;
    //1.2.设置item的间距离
    flow.minimumLineSpacing = HALineSpacing;
    //1.3 设置距离左边的距离
    CGFloat oneX = SCREEN_WIDTH * 0.5 - flow.itemSize.width * 0.5;
    flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView.collectionViewLayout = flow;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[HACollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (fromVC == self && [toVC isKindOfClass:[NextViewController class]]) {
        return [[FirstTransition alloc] init];
    }
    else {
        return nil;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HACollectionViewCell *cell = (HACollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NextViewController *next = [[NextViewController alloc]init];
    next.image = cell.smallImageView.image;
    next.backImage = cell.imageView.image;
    [self.navigationController pushViewController:next animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
