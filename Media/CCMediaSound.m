//
//  CCMediaSound.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/10/23.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCMediaSound.h"

#import <AudioToolbox/AudioToolbox.h>

@implementation CCMediaSound

#pragma mark - method
//
// method
//

// ボタン押下音
+ (void) playButtonSound
{
    static SystemSoundID beepSoundId;
    if(!beepSoundId)
    {
        NSURL *beepWavURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ButtonSound" ofType:@"m4a"] isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)beepWavURL, &beepSoundId);
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        AudioServicesPlaySystemSound(beepSoundId);
    });
}

@end
