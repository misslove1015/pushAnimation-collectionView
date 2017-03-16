//
//  NextViewController.h
//  CustomCollectionView
//
//  Created by miss on 16/11/29.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextViewController : UIViewController
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *backImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@end
