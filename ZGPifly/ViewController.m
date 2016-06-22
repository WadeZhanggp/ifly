//
//  ViewController.m
//  ZGPifly
//
//  Created by 张光鹏 on 16/6/16.
//  Copyright © 2016年 Tsinova. All rights reserved.
//

#import "ViewController.h"
#import "IflySpeakManager.h"
#import <iflyMSC/IFlyRecognizerView.h>
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechUtility.h>
#import <iflyMSC/IFlySetting.h>
#import <iflyMSC/IFlySpeechConstant.h>

@interface ViewController ()<IFlyRecognizerViewDelegate>
{
    IFlyRecognizerView      *_iflyRecognizerView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"555da434"];
    [IFlySpeechUtility createUtility:initString];
    //初始化语音识别控件
    _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    _iflyRecognizerView.delegate = self;
    [_iflyRecognizerView setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path保存录音文件名，如不再需要，设置value为nil表示取消，默认目录是documents
    [_iflyRecognizerView setParameter:@"asrview.pcm " forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //启动识别服务
    [_iflyRecognizerView start];
    
}

/*识别结果返回代理
 @param resultArray 识别结果
 @ param isLast 表示是否最后一次结果
 */
- (void)onResult: (NSArray *)resultArray isLast:(BOOL) isLast{
    
    NSLog(@"result = %@",resultArray);
    
}
/*识别会话错误返回代理
 @ param  error 错误码
 */
- (void)onError: (IFlySpeechError *) error{
    
}


@end
