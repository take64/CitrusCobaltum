//
//  CCAlert.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCAlert.h"

@interface CCAlert ()

@end

@implementation CCAlert

#pragma mark - static method
//
// static method
//

// OKアラート取得
+ (CCAlert *) callOkAlertWithTitle:(NSString *)title messages:(id)messages handler:(void (^)(UIAlertAction *action))handler
{
    // alert
    CCAlert *alert = [CCAlert alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:handler]];
    
    // title
    [alert setTitle:title];
    // message
    NSString *message = @"";
    if([messages isKindOfClass:[NSArray class]] == YES)
    {
        message = [(NSArray *)messages componentsJoinedByString:@"\n"];
    }
    else if([messages isKindOfClass:[NSString class]] == YES)
    {
        message = (NSString *)messages;
    }
    [alert setMessage:message];
    
    return alert;
}

// OKアラート表示
+ (void) okAlertWithTitle:(NSString *)title messages:(id)messages parent:(UIViewController *)parentController handler:(void (^)(UIAlertAction *action))handler
{
    CCAlert *alert = [CCAlert callOkAlertWithTitle:title messages:messages handler:handler];
    [parentController presentViewController:alert animated:YES completion:nil];
}

// アクションシート取得
+ (CCAlert *) callActionSheetWithTitle:(NSString *)title messages:(id)messages actions:(NSArray<UIAlertAction *> *)actions
{
    CCAlert *alert = [CCAlert alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    for(UIAlertAction *action in actions)
    {
        [alert addAction:action];
    }
    
    // title
    [alert setTitle:title];
    // message
    NSString *message = @"";
    if([messages isKindOfClass:[NSArray class]] == YES)
    {
        message = [(NSArray *)messages componentsJoinedByString:@"\n"];
    }
    else if([messages isKindOfClass:[NSString class]] == YES)
    {
        message = (NSString *)messages;
    }
    [alert setMessage:message];
    
    return alert;
}

@end
