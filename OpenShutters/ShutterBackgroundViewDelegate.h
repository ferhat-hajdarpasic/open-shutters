//
//  ShutterBackgroundViewDelegate.h
//  OpenShutters
//
//  Created by Sharad Thapa on 09/12/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShutterBackgroundViewDelegate <NSObject>
-(void)movingShutterMovementUp:(NSString *)data;
-(void)movingShutterMovementDown:(NSString *)data;
-(void)movingShutterMovementCenter:(NSString *)data;
-(BOOL)applyBtnShutterBGSelected:(NSString *)message indxx:(int)ind;
-(void)cancelBtnShutterBGSelected:(NSString *)message indxx:(int)ind;

@end
