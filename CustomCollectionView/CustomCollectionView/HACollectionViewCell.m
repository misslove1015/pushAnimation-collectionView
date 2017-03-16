//
//  HACollectionViewCell.m
//  LetMeSpend
//
//  Created by 袁斌 on 16/5/13.
//  Copyright © 2016年 https://github.com/DefaultYuan/CustomTakePhotoAndCollectionViewAnimation. All rights reserved.
//

#import "HACollectionViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation HACollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.masksToBounds = NO;
        [self.contentView addSubview:self.smallImageView];
        [self.contentView addSubview:self.imageView];
        
//        self.contentView.backgroundColor = [UIColor whiteColor];
//        self.contentView.layer.shadowColor = [UIColorWithHex(0x999999) CGColor];
//        self.contentView.layer.shadowOpacity = 0.8;//透明度
//        self.contentView.layer.shadowRadius = 2;//半径
//        self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
//        self.contentView.layer.cornerRadius = 4;
    }
    return self;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        //UIcollectionView的高度为kMainHeight-别的控件加空白的高度  减的数越大 图片越小
        CGFloat collectionVHeight = self.frame.size.height;
        CGFloat imgWidth = collectionVHeight / HAZoomScale * HAImageScale;
//        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, collectionVHeight / HAZoomScale)];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imageView.image = [UIImage imageNamed:@"2"];
        _imageView.center = self.contentView.center;
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [_imageView setClipsToBounds:YES];
        _imageView.layer.cornerRadius = 4;
    }
    return _imageView;
}

- (UIImageView *)smallImageView{
    if (!_smallImageView) {
        UIImage *image = [self ct_imageFromImage:[UIImage imageNamed:@"2"] inRect:CGRectMake(0, 100, 600, 150*736/SCREEN_WIDTH)];
        
        _smallImageView = [[UIImageView alloc]initWithImage:image];
        //_smallImageView.contentMode = UIViewContentModeTopLeft;
        //_smallImageView.clipsToBounds = YES;
        _smallImageView.center = self.center;
        _smallImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2);
        
    }
    return _smallImageView;
}

- (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}


@end
