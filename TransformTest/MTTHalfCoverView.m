//
//  MTTHalfCoverView.m
//  TransformTest
//
//  Created by 刘浩 on 2018/1/25.
//  Copyright © 2018年 刘浩. All rights reserved.
//

#import "MTTHalfCoverView.h"

@interface MTTHalfCoverView()

@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation MTTHalfCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self == [super initWithFrame:frame]){
        
    }
    return self;
}


- (void)setDirection:(MTTCoverDirection)direction andImage:(NSString*)imageName {
    CGFloat pointX = 0.0f;
    
    if(direction ==MTTCoverDirection_Left){
        pointX = self.frame.size.width *0.5;
    }else{
        pointX = 0;
    }
    [self.imageView setFrame:CGRectMake(pointX, 0, self.frame.size.width *0.5, self.frame.size.height)];
    [self addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:imageName];
    
}


- (UIImageView *)imageView {
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width *0.5, self.frame.size.height)];
        
    }
    return _imageView;
}


@end
