//
//  FirstTransition.m
//  TransitionDemo
//
//  Created by JackXu on 16/7/10.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "FirstTransition.h"
#import "ViewController.h"
#import "NextViewController.h"
#import "HACollectionViewCell.h"

@implementation FirstTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ViewController *fromViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NextViewController *toViewController = (NextViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    //获得cell中的图片的快照
//    JXTableViewCell *cell = (JXTableViewCell*)[fromViewController.tableView cellForRowAtIndexPath:[fromViewController.tableView indexPathForSelectedRow]];
    
    NSIndexPath *indexpath = [fromViewController.collectionView indexPathsForSelectedItems][0];
    HACollectionViewCell *cell = (HACollectionViewCell *)[fromViewController.collectionView cellForItemAtIndexPath:indexpath];
    
    UIView *cellImageSnapshot = [cell.smallImageView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;
    cell.smallImageView.hidden = YES;
    
    
    //设置初始view的状态
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.imageView.hidden = YES;
    toViewController.backImageView.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.alpha = 1.0;
        CGRect frame = [containerView convertRect:toViewController.imageView.frame fromView:toViewController.view];
        cellImageSnapshot.frame = frame;
    }completion:^(BOOL finished) {
        toViewController.imageView.hidden = NO;
        toViewController.backImageView.hidden = NO;
        cell.imageView.hidden = NO;
        cell.smallImageView.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}



@end
