//
//  IflySpeakManager.m
//  ZGPifly
//
//  Created by 张光鹏 on 16/6/16.
//  Copyright © 2016年 Tsinova. All rights reserved.
//

#import "IflySpeakManager.h"
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechUtility.h>
#import <iflyMSC/IFlySetting.h>
#import <iflyMSC/IFlySpeechConstant.h>



static IflySpeakManager *instance;

@interface IflySpeakManager()<IFlySpeechSynthesizerDelegate>

@property (nonatomic, strong) NSMutableArray * sounds;

@property (nonatomic, strong) IFlySpeechSynthesizer *flySpeechSynthesizer;//语音播报


@property (nonatomic, strong) NSString * speakingSound;

@property (atomic, assign,) BOOL isSpeaking;

@end

@implementation IflySpeakManager

+(instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IflySpeakManager alloc] init];
        instance.sounds = [NSMutableArray array];
        [instance initIFlySpeech];
    });
    
    return instance;
    
}

- (void)initIFlySpeech{
    
    [IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@",@"57622178"]];
    [IFlySetting setLogFile:LVL_NONE];
    [IFlySetting showLogcat:NO];
    // 设置语音合成的参数
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];//合成的语速,取值范围 0~100
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];//合成的音量;取值范围 0~100
    
    // 发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    
    // 音频采样率,目前支持的采样率有 16000 和 8000;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    // 当你再不需要保存音频时，请在必要的地方加上这行。
    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    _flySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _flySpeechSynthesizer.delegate = self;
    
    [IflySpeakManager shareInstance].myIFlyRecognizerView = [[ZGPIFlyRecognizerView alloc] init];
    [IflySpeakManager shareInstance].myIFlyRecognizerView.backgroundColor = [UIColor redColor];
    

}

- (void)speaking:(NSString *)soundString{
    
    [self.sounds addObject:soundString];
    [self playSound:soundString];
    
}

- (void)playSound:(NSString *)sound{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
//        if (!_isSpeaking) {
//            _isSpeaking = YES;
//            _speakingSound = sound;
//            [_flySpeechSynthesizer startSpeaking:_speakingSound];
//        }
        _speakingSound = sound;
        [_flySpeechSynthesizer startSpeaking:_speakingSound];
    });
    
}

@end
