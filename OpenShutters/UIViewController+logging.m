//
//  UIViewController+logging.m
//  OpenShutters
//
//  Created by Sharad Thapa on 05/05/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//
#import <objc/runtime.h>
#import "UIViewController+logging.h"

@implementation UIViewController (logging)
-(void) logged_viewDidAppear:(BOOL)animated {
    [self logged_viewDidAppear:animated];
    NSLog(@"logged view did appear for %@", [self class]);
}
+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        SEL viewWillAppearSelector = @selector(viewDidAppear:);
        SEL viewWillAppearLoggerSelector = @selector(logged_viewDidAppear:);
        Method originalMethod = class_getInstanceMethod(self, viewWillAppearSelector);
        Method extendedMethod = class_getInstanceMethod(self, viewWillAppearLoggerSelector);
        method_exchangeImplementations(originalMethod, extendedMethod);
    });
}
@end
