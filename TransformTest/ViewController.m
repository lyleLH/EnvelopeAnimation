//
//  ViewController.m
//  TransformTest
//
//  Created by 刘浩 on 2018/1/19.
//  Copyright © 2018年 刘浩. All rights reserved.
//

#import "ViewController.h"
#import "MTTHalfCoverView.h"
#define kWindowWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kWindowHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface ViewController ()

@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,strong)UIView *letterView;
@property (nonatomic,strong)UIImageView *coverView;
@property (nonatomic,strong)MTTHalfCoverView *leftView;
@property (nonatomic,strong)MTTHalfCoverView *rightView;

@property (nonatomic,strong)CALayer * bgLayer;

@end

@implementation ViewController




-(UIView *)bgView {
    if(!_bgView){

        _bgView = [[UIView alloc] initWithFrame:CGRectMake((kWindowWidth-300)*0.5, (kWindowHeight-470)*0.5, 300, 470)];
        _bgView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bgView;
}

-(UIView *)letterView {
    if(!_letterView){
        _letterView = [[UIView alloc] initWithFrame:self.bgView.bounds];
        _letterView.backgroundColor = [UIColor whiteColor];
    }
    return  _letterView;
}

- (MTTHalfCoverView *)leftView {
    if(!_leftView){
        CGFloat width = CGRectGetWidth(self.bgView.frame)*1.2;
        
        _leftView = [[MTTHalfCoverView alloc] initWithFrame:CGRectMake(-0.5*width, 0, width, self.bgView.frame.size.height)];
    }
    return _leftView;
}



- (MTTHalfCoverView *)rightView {
    if(!_rightView){
        CGFloat width = CGRectGetWidth(self.bgView.frame)*1.2;
        _rightView  = [[MTTHalfCoverView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bgView.frame)-0.5*width, 0, width, self.bgView.frame.size.height)];
    }
    return _rightView;
}

- (UIImageView *)coverView {
    if(!_coverView){
        _coverView = [[UIImageView alloc] initWithFrame:self.bgView.bounds];
        _coverView.image = [UIImage imageNamed:@"0003.png"];
    }
    return _coverView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.letterView];
    [self.bgView addSubview:self.coverView];
    [self.bgView addSubview:self.leftView];
    [self.leftView setDirection:MTTCoverDirection_Left andImage:@"0002.png"];
    [self.bgView addSubview:self.rightView];
    [self.rightView setDirection:MTTCoverDirection_Right andImage:@"0001.png"];
 
    
}



- (IBAction)right:(id)sender {
    [self transformView:self.rightView angle:M_PI  durantion:2.0 anchorPoint:CGPointMake(1, 0.5) completion:^(BOOL finished) {
        
        [self transformView:self.leftView angle:-M_PI  durantion:2.0 anchorPoint:CGPointMake(0, 0.5) completion:^(BOOL finished) {
            
        }];
    }];
}


- (void)transformView:(UIView*)view angle:(CGFloat)angle durantion:(CFTimeInterval)duration anchorPoint:(CGPoint)point  completion:(void (^ __nullable)(BOOL finished))completion{
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

    
    [UIView animateWithDuration:1.5 animations:^{
        view.layer.transform = transform;
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}


- (IBAction)both:(id)sender {
    
    [self cardOutAnimantioncompletion:^(BOOL finished) {
        
    }];
    
}


- (void)cardOutAnimantioncompletion:(void (^ __nullable)(BOOL finished))completion {
    
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/12, 0, 1, 0);
    CATransform3D scale = CATransform3DIdentity;
    CGFloat disZ = 350;
    scale.m34 =  -1.0f/disZ;
    //最终的3D变换矩阵
    CATransform3D transform = CATransform3DConcat(rotate, scale);
    
    CGAffineTransform transform2d = CGAffineTransformIdentity;
    transform2d = CGAffineTransformTranslate(transform2d, -self.bgView.frame.size.width, 0);
    
    [self setAnchorPoint:CGPointMake(0.1, 0.5) forView:self.letterView];
    [UIView animateWithDuration:1.5 animations:^{
       
        [self.bgView.layer insertSublayer:self.leftView.layer above:self.coverView.layer];
        [self.bgView.layer insertSublayer:self.rightView.layer above:self.leftView.layer];
        
        [self.bgView.layer insertSublayer:self.letterView.layer above:self.leftView.layer];
//        [self.bgView.layer insertSublayer:self.coverView.layer  above:self.letterView.layer];
        self.letterView.layer.transform = transform;
        self.letterView.transform = transform2d;
     
        
//        [self.bgView insertSubview:self.letterView atIndex:2];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            CGAffineTransform transform2d2 = CGAffineTransformIdentity;
            transform2d2 = CGAffineTransformTranslate(transform2d, self.bgView.frame.size.width, 0);
            self.letterView.transform = transform2d2;
            [UIView animateWithDuration:.05 animations:^{
                [self setAnchorPoint:CGPointMake(0.5, 0.5) forView:self.letterView];
               

            } completion:^(BOOL finished) {
                
            }];
            
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
@end

