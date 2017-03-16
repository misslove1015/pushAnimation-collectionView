//
//  SecondTransition.m
//  TransitionDemo
//
//  Created by JackXu on 16/7/10.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "SecondTransition.h"
#import "ViewController.h"
#import "NextViewController.h"
#import "HACollectionViewCell.h"

@implementation SecondTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    NextViewController *fromViewController = (NextViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //获得要移动的图片的快照
    UIView *imageSnapshot = [fromViewController.backImageView snapshotViewAfterScreenUpdates:NO];
    
    
    imageSnapshot.frame = [containerView convertRect:fromViewController.backImageView.frame fromView:fromViewController.backImageView.superview];
    fromViewController.backImageView.hidden = YES;
    fromViewController.imageView.hidden = YES;
    
    
    //获得图片对应的cell
//    CollectionViewCell *cell = [toViewController.tableView cellForRowAtIndexPath:[toViewController.tableView indexPathForSelectedRow]];
    
    NSIndexPath *indexPath = [toViewController.collectionView indexPathsForSelectedItems][0];
    HACollectionViewCell *cell = (HACollectionViewCell *)[toViewController.collectionView cellForItemAtIndexPath:indexPath];
    cell.smallImageView.hidden = YES;
    cell.imageView.hidden = YES;
    
    //设置初始view的状态
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView addSubview:imageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.alpha = 0.0;
        imageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    } completion:^(BOOL finished) {
        [imageSnapshot removeFromSuperview];
        fromViewController.imageView.hidden = NO;
        fromViewController.backImageView.hidden = NO;
        cell.imageView.hidden = NO;
        cell.smallImageView.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}




@end
