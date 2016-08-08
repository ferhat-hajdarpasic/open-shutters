//
//  ShutterBackgroundViewDelegate.h
//  OpenShutters
//
//  Created by Sharad Thapa on 09/12/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShutterBackgroundViewDelegate <NSObject>
-(BOOL)movingShutterMovementUp:(NSString *)data;
-(BOOL)movingShutterMovementDown:(NSString *)data;
-(BOOL)movingShutterMovementCenter:(NSString *)data;
-(BOOL)applyBtnShutterBGSelected:(NSString *)message indxx:(int)ind;
-(void)cancelBtnShutterBGSelected:(NSString *)message indxx:(int)ind;

@end
