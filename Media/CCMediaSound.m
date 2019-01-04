//
//  CCMediaSound.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/10/23.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCMediaSound.h"

#import <AudioToolbox/AudioToolbox.h>

static BOOL kEnableButtonSound = YES;



@implementation CCMediaSound

#pragma mark - static method
//
// static method
//

// ボタン押下音の許可
+ (void) enableButtonSound:(BOOL)enable
{
    kEnableButtonSound = enable;
}

// ボタン押下音
+ (void) playButtonSound
{
    if (kEnableButtonSound == NO)
    {
        return;
    }
    
    static SystemSoundID beepSoundId;
    if (!beepSoundId)
    {
        NSURL *beepWavURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ButtonSound" ofType:@"m4a"] isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)beepWavURL, &beepSoundId);
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        AudioServicesPlaySystemSound(beepSoundId);
    });
}

@end
