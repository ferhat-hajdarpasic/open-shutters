//
//  AppDelegate.h
//  OpenShutters
//http://subjective-objective-c.blogspot.in/2011/08/writing-high-quality-view-controller.html
//  Created by Sharad Thapa on 27/10/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)NSString *menu_title;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *array_devices;
@property (nonatomic) int frstScreencount;
@end

