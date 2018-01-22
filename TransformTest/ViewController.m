//
//  ViewController.m
//  TransformTest
//
//  Created by 刘浩 on 2018/1/19.
//  Copyright © 2018年 刘浩. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.bgView bringSubviewToFront:self.rightView];
}

- (IBAction)left:(id)sender {
    
//    [self transformView:self.leftView angle:-M_PI  durantion:2.0 anchorPoint:CGPointMake(0, 0.5)];
}


- (IBAction)right:(id)sender {
    
    [self transformView:self.rightView angle:M_PI  durantion:2.0 anchorPoint:CGPointMake(1, 0.5) completion:^(BOOL finished) {
        [self transformView:self.leftView angle:-M_PI  durantion:2.0 anchorPoint:CGPointMake(0, 0.5) completion:^(BOOL finished) {
            
        }];
    }];
    
}


- (void)transformView:(UIView*)view angle:(CGFloat)angle durantion:(CFTimeInterval)duration anchorPoint:(CGPoint)point  completion:(void (^ __nullable)(BOOL finished))completion{
    //    CATransform3D rotate = CATransform3DMakeRotation(- M_PI/6, 0, 1, 0);
    
    
    //构造一个旋转矩阵
    CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 1, 0);
    //构造一个透视矩阵
    /*
     其中：M34属性 控制透视效果
     
     正的值向下（左）方往里缩放 负的值上（右）方往里缩放
     */
    
    CGFloat disZ = 500;
    
    CATransform3D scale = CATransform3DIdentity;
    
    scale.m34 =  point.x ==0 ?- 1.0f/disZ:1.0f/disZ;
    
    //最终的变换矩阵
    CATransform3D transform = CATransform3DConcat(rotate, scale);

    
    [UIView animateWithDuration:1.5 animations:^{
         view.layer.transform = transform;
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}


- (IBAction)both:(id)sender {
    
    
}


@end
