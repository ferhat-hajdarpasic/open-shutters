
//  ShutterBackgroundView.m
//  OpenShutters
//
//  Created by Sharad Thapa on 03/11/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.

#import "ShutterBackgroundView.h"
#import "ShutterView.h"
#import "Macros.h"
#import "MBProgressHUD.h"


@implementation ShutterBackgroundView
@synthesize startTransform,delegate;
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)])) {
        startTransform.c=.4;
        bladePosition=1;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Hideloader:) name:@"PresetSuccess" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MotorPositionChanged:) name:@"motorPositionChanged" object:nil];
        
        self.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0F/255 blue:245.0F/255 alpha:1];
        blindArr=[[NSMutableArray alloc]init];
        isInside=NO;
        
        btnUp=[UIButton buttonWithType:UIButtonTypeCustom];
        receivedata=[UIButton buttonWithType:UIButtonTypeCustom];
        [receivedata setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [receivedata setFrame:CGRectMake(frame.size.width*0.01,frame.size.height*0.5,400,133)];
        if (IS_IPHONE) {
            [btnUp setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.15,60,63)];
        } else if (IS_IPHONE_5) {
            [btnUp setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.15,60,63)];
        } else {
            [btnUp setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.2,80,85)];
        }
        [btnUp setBackgroundImage:[UIImage imageNamed:@"arrow-up.png"] forState:UIControlStateNormal];
        [btnUp addTarget:self action:@selector(upMove:) forControlEvents:UIControlEventTouchDown];
        
        if (IS_IPHONE) {
            lbl_apply=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.86,50,30)];
        } else if (IS_IPHONE_5) {
            lbl_apply=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.86,50,30)];
        } else {
            lbl_apply=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.95,50,30)];
        }
        lbl_apply.textColor=[UIColor blackColor];
        lbl_apply.text=@"Apply";
        [lbl_apply setFont:[UIFont fontWithName:@"Helvetica-bold" size:8.0f]];
        lbl_apply.numberOfLines=2;
        if (IS_IPHONE) {
            lbl_cancel=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.86,50,30)];
        } else if (IS_IPHONE_5) {
            lbl_cancel=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.86,50,30)];
        } else {
            lbl_cancel=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.95,50,30)];
        }
        lbl_cancel.textColor=[UIColor blackColor];
        lbl_cancel.text=@"Cancel";
        [lbl_cancel setFont:[UIFont fontWithName:@"Helvetica-bold" size:8.0f]];
        lbl_cancel.numberOfLines=2;
        btnDown=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE) {
            [btnDown setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.34 ,60,63)];
        } else if (IS_IPHONE_5) {
            [btnDown setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.34 ,60,63)];
        } else {
            [btnDown setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.48 ,80,85)];
        }
        
        [btnDown setBackgroundImage:[UIImage imageNamed:@"arrow-down.png"] forState:UIControlStateNormal];
        [btnDown addTarget:self action:@selector(downMove:) forControlEvents:UIControlEventTouchDown];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanSlider:)];
        panGesture.delegate = (id <UIGestureRecognizerDelegate>)self;
        
        self.layer.cornerRadius=15.0f;
        
        self.blade_array=[[NSMutableArray alloc]initWithObjects:@"blade_0.png",@"blade_1.png",@"blade_2.png",@"blade_3.png",@"blade_4.png",@"blade_5.png",@"blade_6.png", nil];
        if (IS_IPHONE) {
            lbl_status=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.66,frame.size.width*.8, frame.size.height*0.2)];
            
            [lbl_status setFont:[UIFont fontWithName:@"Helvetica-bold" size:10.0f]];
        } else if (IS_IPHONE_5) {
            lbl_status=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.66,frame.size.width*.8, frame.size.height*0.2)];
            [lbl_status setFont:[UIFont fontWithName:@"Helvetica-bold" size:10.0f]];
        } else {
            lbl_status=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.72,frame.size.width*.8, frame.size.height*0.2)];
            [lbl_status setFont:[UIFont fontWithName:@"Helvetica-bold" size:14.0f]];
        }
        
        lbl_status.textColor=[UIColor blackColor];
        lbl_status.text=@"Press the up & down arrows to move the shutters";
        
        lbl_status.numberOfLines=2;
        lbl_status.textAlignment=NSTextAlignmentCenter;
        
        [imgvArrow setImage:[UIImage imageNamed:@"img4.png"]];
        
        sunImg=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*0.04,frame.size.height*0.04,30,34)];
        [sunImg setImage:[UIImage imageNamed:@"sun.png"]];
        [self addSubview:sunImg];
        if (IS_IPHONE) {
            self.blade_img=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*0.24,frame.size.height*0.05, 270, 380)];
        } else if (IS_IPHONE_5) {
            self.blade_img=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*0.24,frame.size.height*0.05, 270, 380)];
        } else {
            self.blade_img=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*0.24,frame.size.height*0.05, 300, 572)];
        }
        
        [self.blade_img  setImage:[UIImage imageNamed:@"blade_1.png"]];
        [self addSubview:self.blade_img];
        [self addSubview:lbl_status];
        [self addSubview:btnDown];
        [self addSubview:btnUp];
        [self addSubview:lbl_cancel];
        [self addSubview:lbl_apply];
        btn_apply=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE) {
            [btn_apply setFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.8,31,27)];
        } else if (IS_IPHONE_5) {
            [btn_apply setFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.8,31,27)];
        } else {
            [btn_apply setFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.9,31,27)];
        }
        
        [btn_apply setBackgroundImage:[UIImage imageNamed:@"dark_apply.png"] forState:UIControlStateNormal];
        [btn_apply addTarget:self action:@selector(applyBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_apply];
        [self bringSubviewToFront:btn_apply];
        
        btn_cancel=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE) {
            [btn_cancel setFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.8,31,30)];
        } else if (IS_IPHONE_5) {
            [btn_cancel setFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.8,31,30)];
        } else {
            [btn_cancel setFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.9,31,30)];
        }
        
        [btn_cancel setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        [btn_cancel addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn_cancel];
        
        [self bringSubviewToFront:btn_cancel];
    }
    
    return self;
    
}

-(void)Hideloader:(NSNotification *)notify {
    [MBProgressHUD hideHUDForView:self animated:YES];
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                            message:@"Successfully Done."
                                            delegate:self
                                            cancelButtonTitle:@"ok"
                                            otherButtonTitles:nil];
    [alert show];
}

-(void)hideApplyCancel {
    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    [csensor  counterUploadshuttr:YES UUID:self.UUIDD presetshutter:@"shutterMotor" on:NO];
    btn_apply.hidden=YES;
    btn_cancel.hidden=YES;
    lbl_apply.hidden=YES;
    lbl_cancel.hidden=YES;

}
-(void)MotorPositionChanged:(NSNotification *)notify {
    NSNumber* temp = [[notify userInfo] valueForKey:@"MotorPosition"];
    int position = temp.intValue;
    bladePosition = position;
    [MBProgressHUD hideHUDForView:self animated:YES];
    [self.blade_img setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d", position]]];
}

-(void)showApplyCancel {
    if ([self.old_new_preset isEqualToString:@"newpreset"]) {
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",1]]];
        bladePosition=1;
    } else {
        int vallll=[self.preset.mottor intValue];
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",vallll]]];
        bladePosition=vallll;
    }
    
    btn_apply.hidden=NO;
    btn_cancel.hidden=NO;
    lbl_apply.hidden=NO;
    lbl_cancel.hidden=NO;
}

-(void)readMOtor
{
      
}
-(void)recivedata:(id)sender {
    UIButton *btn=(UIButton *)sender;
    NSUserDefaults *defff=[NSUserDefaults standardUserDefaults];
    NSString *strr=[defff objectForKey:@"Michaeldata"];
    [btn setTitle:[NSString stringWithFormat:@"%@",strr] forState:UIControlStateNormal];
}

- (int)findPresetIndex:(NSMutableDictionary *)presetToCheck savedPresets:(NSMutableArray *)savedPresets {
    for (int i = 0; i < savedPresets.count; i++) {
        NSMutableArray *arrr=[savedPresets objectAtIndex:i];
        if (arrr.count > 0) {
            for (int kk = 0; kk < arrr.count; kk++) {
                Preset *  preset = (Preset*)[arrr objectAtIndex:0];
                if ([preset.name isEqualToString:[presetToCheck valueForKey:@"name"]]) {
                    return i;
                }
            }
        }
    }
    return -1;
}

- (BOOL)checkPresetNameExists:(NSMutableDictionary *)presetToCheck savedPresets:(NSMutableArray *)savedPresets {
    BOOL isThere = NO;
    if([self findPresetIndex:presetToCheck savedPresets:savedPresets] != -1) {
        isThere=YES;
        UIAlertView * alert =[[UIAlertView alloc ]
                              initWithTitle:@"Open Shutter"
                              message:@"You Already have a Preset with same name."
                              delegate:self
                              cancelButtonTitle:@"ok"
                              otherButtonTitles: nil];
        [alert show];
    }
    return isThere;
}

- (NSMutableDictionary *)preset:(NSUserDefaults *)userDeafult {
    NSMutableDictionary *diccttt= [(NSMutableDictionary*)[userDeafult  objectForKey:@"NEWPRESET_DATA"]mutableCopy];
    return diccttt;
}

- (NSMutableArray *)getSavedPresets {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved_presets"];
    NSMutableArray *savedPresets= [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:data error:nil];
    return savedPresets;
}

- (BOOL)checkPresetNameExists1:(NSMutableDictionary *)preset {
    NSMutableArray *savedPresets = [self getSavedPresets];
    BOOL presetNameExists = [self checkPresetNameExists:preset savedPresets:savedPresets];
    return presetNameExists;
}

-(void)applypreset {
    if ([self.old_new_preset isEqualToString:@"newpreset"]) {
        NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *preset = [self preset:userDeafult];
        BOOL presetNameExists = [self checkPresetNameExists1:preset];
        if (presetNameExists == NO) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.labelText = @"Loading.";
            
            [hud show:YES];

            [preset setObject: [NSString stringWithFormat:  @"%d",bladePosition] forKey : @"motor"];
            [preset setObject: self.UUIDD forKey:  @"UUID"];
            [preset setObject: @"newpreset" forKey : @"NEWPREST"];
            
            csensor=[CustomSensor sharedCustomSensor];
            csensor.delegate=self;
            [csensor writePresets:preset newPreset:@"newpreset"];
        }
    } else if ([self.old_new_preset isEqualToString:@"oldpreset"]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.labelText = @"Loading.";
        
        [hud show:YES];
        
        NSMutableDictionary *preset= [[NSMutableDictionary alloc]init];
        
        [preset setObject:self.preset.name forKey:@"name"];
        [preset setObject:self.preset.min forKey:@"min"];
        [preset setObject:self.preset.hour forKey:@"hour"];
        [preset setObject:self.preset.days forKey:@"days"];
        [preset setObject:[NSString stringWithFormat:@"%d",bladePosition] forKey:@"motor"];
        [preset setObject:self.preset.uuid_device forKey:@"UUID"];

        [preset setObject:@"oldpreset" forKey:@"NEWPREST"];
        csensor=[CustomSensor sharedCustomSensor];
        csensor.delegate=self;
        [csensor writePresets:preset newPreset:@"oldpreset"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self applypreset];
    }
}
-(void)applyBtnPressed:(id)sender {
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                            message:@"Apply to Preset!"
                                            delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Apply", nil];
    [alert show];
    if([self.delegate respondsToSelector:@selector(applyBtnShutterBGSelected:indxx:)]) {
    }
}

-(void)cancelBtnPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(cancelBtnShutterBGSelected:indxx:)]) {
        [self.delegate cancelBtnShutterBGSelected:@"preset" indxx:1];
    }
}

- (void)moveMotorToBladePosition {
    if (bladePosition >= 0 && bladePosition < 7) {
        if ([self.delegate respondsToSelector:@selector(moveShutterToPosition:)]) {
            BOOL isMovingMotor = [self.delegate moveShutterToPosition:[NSString stringWithFormat:@"%d",bladePosition]];
            if(isMovingMotor) {
                [self showProgress:@"Wating for motor."];
            }
        }
    }
}

- (void)moveBladeUp {
    ++bladePosition;
    if (bladePosition < 0) {
        bladePosition = 0;
    }
    if (bladePosition > 6) {
        bladePosition = 6;
    }
    if (bladePosition >= 0 && bladePosition < 7) {
        self.blade_img.image=nil;
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",bladePosition]]];
    }
}

-(void)upMove:(id)sender {
    if(bladePosition < 6) {
        [self moveBladeUp];
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(BladeMoveTimer:) userInfo:nil repeats:YES];
    }
}

- (void)showProgress:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.labelText = title;
    [hud show:YES];
}

- (void)moveBladeDown {
    --bladePosition;
    if (bladePosition > 6) {
        bladePosition = 6;
    }
    if (bladePosition < 0) {
        bladePosition = 0;
    }
    if (bladePosition >= 0 && bladePosition < 7) {
        self.blade_img.image=nil;
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",bladePosition]]];
    }
}

-(void)downMove:(id)sender {
    if(bladePosition > 0) {
        [self moveBladeDown];
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(BladeMoveTimer:) userInfo:nil repeats:YES];
    }
}

-(void)BladeMoveTimer:(NSTimer*)theTimer {
    if(btnUp.isTouchInside == true) {
        [self moveBladeUp];
    }
    if(btnDown.isTouchInside == true) {
        [self moveBladeDown];
    }
    if(!btnUp.isTouchInside && !btnDown.isTouchInside) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [theTimer invalidate];
            [self moveMotorToBladePosition];
        });
    }
}


-(void)didPanSlider:(UIPanGestureRecognizer *)panGesture {
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            deltaAngle=0.0f;
            CGPoint currentlocation = [panGesture locationInView:self];
            if (CGRectContainsPoint(btnUp.frame, currentlocation)) {
                float dx;
                float dy = 0.0;
                for (int i=0;i<[blindArr count]; i++) {
                    ShutterView *shuttr=(ShutterView *)[blindArr objectAtIndex:i];
                    dx = currentlocation.x - shuttr.center.x;
                    dy = currentlocation.y - shuttr.center.y;
                    deltaAngle = atan2(dy,dx);
                    startTransform = shuttr.transform;
                    shuttr.transform = CGAffineTransformMakeRotation(deltaAngle );
                }
                [btnCenter setFrame:CGRectMake(btnCenter.frame.origin.x,dy, btnCenter.frame.size.width, btnCenter.frame.size.height)];
            }
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint currentlocation = [panGesture locationInView:self];
            if (CGRectContainsPoint(imgvArrow.frame, currentlocation)) {
                shuttr0=(ShutterView *)[blindArr objectAtIndex:0];
                shuttr1=(ShutterView *)[blindArr objectAtIndex:1];
                shuttr2=(ShutterView *)[blindArr objectAtIndex:2];
                shuttr3=(ShutterView *)[blindArr objectAtIndex:3];
                shuttr4=(ShutterView *)[blindArr objectAtIndex:4];
                
                
                CGPoint pt = [panGesture locationInView:self];
                float dx = pt.x  - shuttr2.center.x;
                float dy = pt.y  - shuttr2.center.y;
                [btnCenter setFrame:CGRectMake(btnCenter.frame.origin.x,pt.y*0.74, btnCenter.frame.size.width, btnCenter.frame.size.height)];
                float ang = atan2(dy,dx);
                float angleDifference = deltaAngle - ang;
                
                deltaAngle = atan2(dy,dx);
                
                CGFloat radians = atan2f(startTransform.b, startTransform.a);
                
                if (deltaAngle >- .88 && deltaAngle < 0.88) {
                    shuttr0.transform = CGAffineTransformMakeRotation(deltaAngle*1.5);
                    shuttr1.transform = CGAffineTransformMakeRotation(deltaAngle*1.5);
                    shuttr2.transform = CGAffineTransformMakeRotation(deltaAngle*1.5);
                    shuttr3.transform = CGAffineTransformMakeRotation(deltaAngle*1.5);
                    shuttr4.transform = CGAffineTransformMakeRotation(deltaAngle*1.5);
                    startTransform=shuttr0.transform;
                }
                if (deltaAngle>.27) {
                    shuttr0.shadowimg.alpha = 0;
                    shuttr1.shadowimg.alpha =0;
                    shuttr2.shadowimg.alpha = 0;
                    shuttr3.shadowimg.alpha = 0;
                    shuttr4.shadowimg.alpha = 0;
                } else if (deltaAngle > .24 && deltaAngle < .27) {
                    if ([self.delegate respondsToSelector:@selector(movingShutterMovementCenter:)]) {
                    }
                } else {
                    shuttr0.shadowimg.alpha = 1;
                    shuttr1.shadowimg.alpha =1;
                    shuttr2.shadowimg.alpha = 1;
                    shuttr3.shadowimg.alpha = 1;
                    shuttr4.shadowimg.alpha = 1;
                    if ([self.delegate respondsToSelector:@selector(movingShutterMovementUp:)]) {
                    }
                }
                NSLog(@"delta andgl %f",deltaAngle);
           }
        }
        case UIGestureRecognizerStateEnded: {
             shuttr0.transform = startTransform;
            shuttr1.transform = startTransform;
            shuttr2.transform =startTransform;
            shuttr3.transform = startTransform;
            shuttr4.transform = startTransform;
            isInside=NO;
        }
    }
}

-(void)drawRect:(CGRect)rect {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(-15, 20), 5);
    [super drawRect: rect];
    CGContextRestoreGState(currentContext);
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    isInside=NO;
}

@end
