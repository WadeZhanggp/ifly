//
//  IflySpeakManager.h
//  ZGPifly
//
//  Created by 张光鹏 on 16/6/16.
//  Copyright © 2016年 Tsinova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZGPIFlyRecognizerView.h"

@interface IflySpeakManager : NSObject

@property (nonatomic, strong) ZGPIFlyRecognizerView *myIFlyRecognizerView;

+ (instancetype)shareInstance;

- (void)speaking:(NSString *)soundString;

@end
