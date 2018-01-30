//
//  MTTHalfCoverView.h
//  TransformTest
//
//  Created by 刘浩 on 2018/1/25.
//  Copyright © 2018年 刘浩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MTTCoverDirection) {
    MTTCoverDirection_Left,
    MTTCoverDirection_Right,
};


@interface MTTHalfCoverView : UIView

- (void)changeSide ;
- (void)setDirection:(MTTCoverDirection)direction andImage:(NSString*)imageName;

@end
