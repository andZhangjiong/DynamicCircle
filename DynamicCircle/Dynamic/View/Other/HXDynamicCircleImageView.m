//
//  HXDynamicCircleImageView.m
//  HongXun
//
//  Created by 张炯 on 2017/11/28.
//

#import "HXDynamicCircleImageView.h"
#import <UIButton+WebCache.h>
#import <FLAnimatedImage.h>
#import <AVKit/AVKit.h>
#import <SDImageCache.h>
#import <UIImageView+WebCache.h>

#define     WIDTH_IMAGE_ONE     (WIDTH_SCREEN - 70) * 0.4
#define     WIDTH_IMAGE         (WIDTH_SCREEN - 70) * 0.31
#define     SPACE               4.0

@interface HXDynamicCircleImageView ()

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong) UIImage *thumb;

@end

@implementation HXDynamicCircleImageView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewTagWithAction)];
        tap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tap];

        CGFloat cellW = 100;
        CGFloat padding = (WIDTH_SCREEN - cellW * 3 ) / 2 - 10;

        _imageViews = @[].mutableCopy;
        for (int i = 0; i < 9; ++i) {
            int row = i / 3;
            int col = i % 3;

            FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            imageView.contentMode =  UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [self addSubview:imageView];

            CGFloat cellX = padding + col * (cellW + 5);
            CGFloat cellY = row * (cellW + 5) + 18;
            imageView.frame = CGRectMake(cellX, cellY, cellW, cellW);

            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClicked:)];
            [imageView addGestureRecognizer:tap];

            [_imageViews addObject:imageView];
            
            UILabel *gifLable = [[UILabel alloc] init];
            gifLable.text = @"GIF";
            gifLable.hidden = YES;
            gifLable.tag = 777;
            gifLable.textColor = [UIColor whiteColor];
            gifLable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            gifLable.textAlignment = NSTextAlignmentCenter;
            gifLable.font = [UIFont systemFontOfSize:10];
            [imageView addSubview:gifLable];
            
            gifLable.sd_layout
            .bottomSpaceToView(imageView, 0)
            .rightSpaceToView(imageView, 0)
            .widthIs(30)
            .heightIs(15);
        }
    }
    return self;
}

- (void)backViewTagWithAction
{
  
}

- (void)setSpicpaths:(NSArray *)spicpaths
{
    _spicpaths = spicpaths;

    if (spicpaths.count == 0) {
        return;
    }
    
    CGFloat imageWidth;
    CGFloat imageHeight;
    if (spicpaths.count == 1) {
        imageWidth = WIDTH_IMAGE_ONE;
        imageHeight = imageWidth / WIDTH_SCREEN * HEIGHT_SCREEN;//imageWidth * 0.8;
    }
    else {
        imageHeight = imageWidth = WIDTH_IMAGE;
    }
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0;  i < 9; i++) {
        FLAnimatedImageView *imageView = self.imageViews[i];
        if (i < self.spicpaths.count) {
            
            imageView.hidden = NO;
            [imageView setFrame:CGRectMake(x, y, imageWidth, imageHeight)];

            NSString *url = [NSString stringWithFormat:@"%@%@",@"",spicpaths[i]];
            HXWeakSelf(self);
            
            UILabel *gifLable = [imageView viewWithTag:777];
            gifLable.hidden = YES;
            gifLable.text = @"";
            
            if (url.length) {

                // 角标
                if (self.bpicpaths && self.bpicpaths.count == self.spicpaths.count) {
                    NSString *bt = self.bpicpaths[i];
                    if ([bt rangeOfString:@"gif"].length > 0) {
                        gifLable.hidden = NO;
                        gifLable.text = @"GIF";
                    }
                    else if ([bt rangeOfString:@"mp4"].length > 0) {
                        gifLable.hidden = NO;
                        gifLable.text = @"MP4";
                    }
                }

                // gif
                if ([url rangeOfString:@"gif"].length > 0) {
                    
                    gifLable.hidden = NO;
                    gifLable.text = @"GIF";
                    
//                    NSData *imageData = [[SDImageCache sharedImageCache] diskImageDataBySearchingAllPathsForKey:url];
//
//                    if (imageData) {
//                        imageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
//                    }
//                    else {
//                        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//                        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//                            if (image) {
//                                [[SDImageCache sharedImageCache] storeImageDataToDisk:data forKey:url];
//
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    imageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
//                                });
//                            }
//                        }];
//                    }
                }
                else if ([gifLable.text isEqualToString:@"MP4"]) {
                    
                    NSString *btUrl = self.bpicpaths[i];
                    if (!self.thumb) {
                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                            UIImage *image = [self getThumbnailImage:[NSString stringWithFormat:@"%@%@",@"",btUrl]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                imageView.image = image;
                                self.thumb = image;
                                [self setNeedsLayout];
                            });
                        });
                    }
                    else {
                        imageView.image = self.thumb;
                    }
                }
                else {
                    [imageView sd_setImageWithURL:HXURL(url) placeholderImage:[UIImage imageNamed:@"loading_commodity"]];
                }
            }
            
            if ((i != 0 && spicpaths.count != 4 && (i + 1) % 3 == 0) || (spicpaths.count == 4 && i == 1)) {
                y += (imageHeight + SPACE);
                x = 0;
            }
            else {
                x += (imageWidth + SPACE);
            }
        }
        else {

            imageView.hidden = YES;
        }
    }
}

- (void)setOne_img_width:(CGFloat)one_img_width
{
    FLAnimatedImageView *imageView = self.imageViews.firstObject;

    if (one_img_width == imageView.width) {
        return;
    }
    
    _one_img_width = one_img_width;
    imageView.width = one_img_width;
}

- (void)setOne_img_height:(CGFloat)one_img_height
{
    FLAnimatedImageView *imageView = self.imageViews.firstObject;
    
    if (one_img_height == imageView.height) {
        return;
    }
    
    _one_img_height = one_img_height;
    imageView.height = one_img_height;
}

- (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size
{
    CGSize originalsize = [originalImage size];
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        rate = widthRate>heightRate?heightRate:widthRate;
        CGImageRef imageRef = nil;
        
        if (heightRate>widthRate)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
    }
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        if(originalsize.height>size.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, 0, originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, 0, size.width, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
    }
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}

- (void)removeAllSubViews
{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark - # Event Response
- (void)buttonClicked:(UITapGestureRecognizer *)sender
{
    NSMutableArray *images = @[].mutableCopy;
    NSMutableArray *imageViews = @[].mutableCopy;
    NSMutableArray *_imageViewFrameArray = @[].mutableCopy;

    NSInteger i = 0;
    for (FLAnimatedImageView *imageView in self.imageViews) {
        if (i < _spicpaths.count) {
            [imageViews addObject:imageView];
            
            if (imageView.image) {
                [images addObject:imageView.image];
            }
            
            CGPoint fromCenter = [imageView
                                  convertPoint:CGPointMake(0, 0)
                                  toView:[UIApplication sharedApplication].keyWindow];
            
            NSValue *frameValue = [NSValue valueWithCGRect:CGRectMake(fromCenter.x, fromCenter.y, imageView.frame.size.width, imageView.frame.size.height)];
            
            [_imageViewFrameArray addObject:frameValue];
        }
        ++i;
    }
    
    if (_dynamicCircleImageViewWithBlock) {
        _dynamicCircleImageViewWithBlock(sender.view.tag,images.copy,imageViews,_bpicpaths,_imageViewFrameArray);
    }
}

- (UIImage *)getThumbnailImage:(NSString *)videoURL

{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}

@end
