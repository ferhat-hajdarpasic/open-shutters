//
//  VerifyMobileDelegate.h
//  Unninr
//
//  Created by Sharad Thapa on 23/04/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomSensorDelegate <NSObject>
-(void)devicesFound:(NSMutableArray *)arrrr;
-(void)readMotorValue:(int)vall;
-(void)VerifyMobileUploadUnSuccessfullWithError:(NSError *)error;
-(void)loadPresets:(NSMutableArray *)presetsss;
@end
