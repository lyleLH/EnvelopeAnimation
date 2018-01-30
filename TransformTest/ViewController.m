//
//  ViewController.m
//  TransformTest
//
//  Created by 刘浩 on 2018/1/19.
//  Copyright © 2018年 刘浩. All rights reserved.
//

#import "ViewController.h"
#import "MTTLettersView.h"
@interface ViewController ()

@property (nonatomic,strong)MTTLettersView * letterView ;
@end

@implementation ViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.letterView = [[MTTLettersView alloc] initWithFrame:CGRectMake((kWindowWidth-300)*0.5, (kWindowHeight-470)*0.5, 300, 470)];
    
    [self.view addSubview:self.letterView];

}



- (IBAction)right:(id)sender {
    [self.letterView openLetterAction];
}




- (IBAction)both:(id)sender {
    
}


@end

