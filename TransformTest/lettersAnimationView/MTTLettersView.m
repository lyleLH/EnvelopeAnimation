//
//  MTTLettersView.m
//  TransformTest
//
//  Created by 刘浩 on 2018/1/29.
//  Copyright © 2018年 刘浩. All rights reserved.
//

#import "MTTLettersView.h"
#import "MTTHalfCoverView.h"

@interface MTTLettersView()
@property (nonatomic,strong)UIImageView *bottomView;

@property (nonatomic,strong)UIView *letterView;

@property (nonatomic,strong)UIImageView *coverView;

@property (nonatomic,strong)MTTHalfCoverView *leftView;

@property (nonatomic,strong)MTTHalfCoverView *rightView;

@end

@implementation MTTLettersView

- (void)openLetterAction{
    CGFloat width = CGRectGetWidth(self.leftView.frame)*0.5;
    self.bottomView.layer.transform = CATransform3DMakeTranslation(0, 0, -width);
    self.letterView.layer.transform = CATransform3DMakeTranslation(0, 0, -width);
    self.coverView.layer.transform = CATransform3DMakeTranslation(0, 0, -width);
    [self transformView:self.rightView angle:M_PI  durantion:1.0 anchorPoint:CGPointMake(1, 0.5) completion:^(BOOL finished) {
        [self transformView:self.leftView angle:-M_PI  durantion:1.0 anchorPoint:CGPointMake(0, 0.5) completion:^(BOOL finished) {
            self.letterView.layer.transform = CATransform3DMakeTranslation(0, 0, width);
            self.coverView.layer.transform = CATransform3DMakeTranslation(0, 0, width);
            [self cardOutAnimantioncompletion:^(BOOL finished) {
            }];
        }];
    }];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.bottomView];
        [self addSubview:self.letterView];
        [self addSubview:self.coverView];
        [self addSubview:self.leftView];
        [self.leftView setDirection:MTTCoverDirection_Left andImage:@"0002"];
        [self addSubview:self.rightView];
        [self.rightView setDirection:MTTCoverDirection_Right andImage:@"0001"];
    }
    return self;
}


- (void)transformView:(UIView*)view angle:(CGFloat)angle durantion:(CFTimeInterval)duration anchorPoint:(CGPoint)point  completion:(void (^ __nullable)(BOOL finished))completion{
    MTTHalfCoverView *halfView = (MTTHalfCoverView *)view;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration / 2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [halfView  changeSide];
    });
    
    //构造一个旋转矩阵
    CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 1, 0);
    //构造一个透视矩阵
    /*
     其中：M34属性 控制透视效果
     
     正的值向下（左）方往里缩放 负的值上（右）方往里缩放
     */
    CATransform3D scale = CATransform3DIdentity;
    CGFloat disZ = 500;
    scale.m34 =  (point.x -0)<0.01 ?- 1.0f/disZ:1.0f/disZ;
    //最终的变换矩阵
    CATransform3D transform = CATransform3DConcat(rotate, scale);
    [UIView animateWithDuration:duration animations:^{
        view.layer.transform = transform;
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}


- (CATransform3D)cardOutTransform {
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/12, 0, 1, 0);
    CATransform3D scale = CATransform3DMakeScale(0.9,0.9,1.0);
    CATransform3D positionTransform = CATransform3DMakeTranslation(-self.bottomView.frame.size.width*1.2, 0, 0); //位置移动
    CGFloat disZ = 700;
    scale.m34 =  -1.0f/disZ;
    CATransform3D transform = CATransform3DConcat(rotate, scale);
    return  CATransform3DConcat(transform, positionTransform);
}

- (CATransform3D)cardInTransform {
    CGFloat width = CGRectGetWidth(self.leftView.frame) ;
    return  CATransform3DMakeTranslation(0, 0, width+100);
}


- (void)cardOutAnimantioncompletion:(void (^ __nullable)(BOOL finished))completion {
    CGAffineTransform transform2d = CGAffineTransformIdentity;
    transform2d = CGAffineTransformTranslate(transform2d, -self.bottomView.frame.size.width, 0);
    [self setAnchorPoint:CGPointMake(0.1, 0.5) forView:self.letterView];
    [UIView animateWithDuration:0.8 animations:^{
        self.letterView.layer.transform = [self cardOutTransform];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.2 animations:^{
            self.coverView.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
            self.letterView.layer.transform = [self cardInTransform];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)cardFrontAnimationcompletion:(void (^ __nullable)(BOOL finished))completion {
    
    
}

- (void) setAnchorPoint:(CGPoint)anchorpoint forView:(UIView *)view{
    CGRect oldFrame = view.frame;
    view.layer.anchorPoint = anchorpoint;
    view.frame = oldFrame;
}


#pragma mark -- properties

-(UIImageView *)bottomView {
    if(!_bottomView){
        
        _bottomView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bottomView.backgroundColor = [UIColor lightGrayColor];
        _bottomView.image = [UIImage imageNamed:@"0004.png"];
    }
    return _bottomView;
}


-(UIView *)letterView {
    if(!_letterView){
        _letterView = [[UIView alloc] initWithFrame:self.bottomView.frame];
        _letterView.backgroundColor = [UIColor greenColor];
    }
    return  _letterView;
}

- (MTTHalfCoverView *)leftView {
    if(!_leftView){
        CGFloat width = CGRectGetWidth(self.bottomView.frame)*1.2;
        
        _leftView = [[MTTHalfCoverView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.bottomView.frame)-0.5*width, self.bottomView.frame.origin.y, width, self.bottomView.frame.size.height)];
    }
    return _leftView;
}



- (MTTHalfCoverView *)rightView {
    if(!_rightView){
        CGFloat width = CGRectGetWidth(self.bottomView.frame)*1.2;
        _rightView  = [[MTTHalfCoverView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bottomView.frame)-width*0.5, self.bottomView.frame.origin.y, width, self.bottomView.frame.size.height)];
    }
    return _rightView;
}

- (UIImageView *)coverView {
    if(!_coverView){
        
        _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(50, CGRectGetMinY(self.bottomView.frame), CGRectGetWidth(self.bottomView.frame)-50, CGRectGetHeight(self.bottomView.frame))];
        _coverView.image = [UIImage imageNamed:@"0003.png"];
    }
    return _coverView;
}

@end
