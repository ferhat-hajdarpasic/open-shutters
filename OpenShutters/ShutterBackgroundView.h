//
//  ShutterBackgroundView.h
//  OpenShutters
//
//  Created by Sharad Thapa on 03/11/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
#import <UIKit/UIKit.h>
#import "ShutterView.h"
#import "ShutterBackgroundViewDelegate.h"
#import "CustomSensor.h"
#import "Preset.h"
@interface ShutterBackgroundView : UIView<CustomSensorDelegate>{
    
    UIImageView *imgvArrow;
    UIImageView *imgvWhiteBall;
    UIImageView *imgBackbrnd;
    UIImageView *sunImg;
    UILabel *lbl_status;
    NSMutableArray *blindArr;
    NSMutableArray *shadowarr;
    BOOL isInside;
    UIButton *btnUp;
    UIButton *receivedata;
    UIButton *btnCenter;
    UIButton *btnDown;
    UILabel *lbl_apply;
    UILabel *lbl_cancel;
    UIButton *btn_apply;
    UIButton *btn_cancel;
    NSTimer *timer;
    ShutterView *shuttr0;
    ShutterView *shuttr1;
    ShutterView *shuttr2;
    ShutterView *shuttr3;
    ShutterView *shuttr4;
    int bladePosition;
    BOOL preventDoubleTap;
    CustomSensor *csensor;
    
}
-(void)hideApplyCancel;
-(void)showApplyCancel;
-(void)readMOtor;
@property (nonatomic,strong)UIImageView *blade_img;
@property (nonatomic,strong)NSMutableArray *blade_array;
@property CGAffineTransform startTransform;
@property (nonatomic,retain)NSString *status;
@property (nonatomic,retain)NSString *UUIDD;
@property (nonatomic,retain)NSString *old_new_preset;
@property (nonatomic,retain)Preset *preset;
@property (strong, nonatomic)NSMutableArray *preset_arrrr;

@property (nonatomic,weak)id <ShutterBackgroundViewDelegate> delegate;
@end
