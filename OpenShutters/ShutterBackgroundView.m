
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
        blade_count=1;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Hideloader:) name:@"PresetSuccess" object:nil];

        self.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0F/255 blue:245.0F/255 alpha:1];
        blindArr=[[NSMutableArray alloc]init];
        isInside=NO;
       
        btnUp=[UIButton buttonWithType:UIButtonTypeCustom];
         receivedata=[UIButton buttonWithType:UIButtonTypeCustom];
        [receivedata setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [receivedata setFrame:CGRectMake(frame.size.width*0.01,frame.size.height*0.5,400,133)];
        if (IS_IPHONE) {
            [btnUp setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.15,60,63)];
        }
      
        else if (IS_IPHONE_5)
        {
          [btnUp setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.15,60,63)];
        
        }
        else{
        
        
          [btnUp setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.2,80,85)];
        
        }
        [btnUp setBackgroundImage:[UIImage imageNamed:@"arrow-up.png"] forState:UIControlStateNormal];
        [btnUp addTarget:self action:@selector(upMoveStop:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
        
        if (IS_IPHONE) {
             lbl_apply=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.86,50,30)];
        }
        
        else if (IS_IPHONE_5)
        {
            lbl_apply=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.86,50,30)];
            
        }
        else{
            
             lbl_apply=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.95,50,30)];
            
        }
        lbl_apply.textColor=[UIColor blackColor];
        lbl_apply.text=@"Apply";
        [lbl_apply setFont:[UIFont fontWithName:@"Helvetica-bold" size:8.0f]];
        lbl_apply.numberOfLines=2;
       
       
        // [self bringSubviewToFront:lbl_apply];
        

    //// ////  /// /////
        if (IS_IPHONE) {
             lbl_cancel=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.86,50,30)];
        }
        
        else if (IS_IPHONE_5)
        {
            lbl_cancel=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.86,50,30)];
            
        }
        else{
            
            lbl_cancel=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.95,50,30)];
            
        }
        

   
    lbl_cancel.textColor=[UIColor blackColor];
    lbl_cancel.text=@"Cancel";
    [lbl_cancel setFont:[UIFont fontWithName:@"Helvetica-bold" size:8.0f]];
      //  [receivedata.titleLabel setFont:[UIFont fontWithName:@"Helvetica-bold" size:10.0f]];
    lbl_cancel.numberOfLines=2;
    

    /////
    btnDown=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE) {
             [btnDown setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.34 ,60,63)];
        }
        
        else if (IS_IPHONE_5)
        {
             [btnDown setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.34 ,60,63)];
            
        }
        else{
            
            
             [btnDown setFrame:CGRectMake(frame.size.width*0.6,frame.size.height*0.48 ,80,85)];
            
        }

   
    [btnDown setBackgroundImage:[UIImage imageNamed:@"arrow-down.png"] forState:UIControlStateNormal];
   // [btnDown addTarget:self action:@selector(downMove:) forControlEvents:UIControlEventTouchDown];
    [btnDown addTarget:self action:@selector(downMoveStop:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanSlider:)];
    panGesture.delegate = (id <UIGestureRecognizerDelegate>)self;
    //[btnUp addGestureRecognizer:panGesture];
    
    self.layer.cornerRadius=15.0f;
    
    self.blade_array=[[NSMutableArray alloc]initWithObjects:@"blade_0.png",@"blade_1.png",@"blade_2.png",@"blade_3.png",@"blade_4.png",@"blade_5.png",@"blade_6.png", nil];
    
       ////////////////
        
        if (IS_IPHONE) {
            lbl_status=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.66,frame.size.width*.8, frame.size.height*0.2)];

            [lbl_status setFont:[UIFont fontWithName:@"Helvetica-bold" size:10.0f]];
        }
        
        else if (IS_IPHONE_5)
        {
            lbl_status=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.66,frame.size.width*.8, frame.size.height*0.2)];

            [lbl_status setFont:[UIFont fontWithName:@"Helvetica-bold" size:10.0f]];
            
        }
        else{
            
            lbl_status=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.72,frame.size.width*.8, frame.size.height*0.2)];

            [lbl_status setFont:[UIFont fontWithName:@"Helvetica-bold" size:14.0f]];
            
        }

        lbl_status.textColor=[UIColor blackColor];
        lbl_status.text=@"Press the up & down arrows to move the shutters";
        
        

       // [lbl_status setFont:[UIFont fontWithName:@"Helvetica-bold" size:14.0f]];
        lbl_status.numberOfLines=2;
        lbl_status.textAlignment=NSTextAlignmentCenter;
        
        [imgvArrow setImage:[UIImage imageNamed:@"img4.png"]];
        
        sunImg=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*0.04,frame.size.height*0.04,30,34)];
        [sunImg setImage:[UIImage imageNamed:@"sun.png"]];
        [self addSubview:sunImg];
        if (IS_IPHONE) {
             self.blade_img=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*0.24,frame.size.height*0.05, 270, 380)];
        }
        
        else if (IS_IPHONE_5)
        {
              self.blade_img=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*0.24,frame.size.height*0.05, 270, 380)];
            
        }
        else{
            
            
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
        }
        
        else if (IS_IPHONE_5)
        {
              [btn_apply setFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.8,31,27)];
            
        }
        else{
            
            
               [btn_apply setFrame:CGRectMake(frame.size.width*0.1,frame.size.height*0.9,31,27)];
            
        }

     
        [btn_apply setBackgroundImage:[UIImage imageNamed:@"dark_apply.png"] forState:UIControlStateNormal];
        [btn_apply addTarget:self action:@selector(applyBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_apply];
        [self bringSubviewToFront:btn_apply];
        
        btn_cancel=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE) {
           
            [btn_cancel setFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.8,31,30)];
      
        }
        
        else if (IS_IPHONE_5)
        {
            
            [btn_cancel setFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.8,31,30)];
            
        }
        else{
            
            
         
            [btn_cancel setFrame:CGRectMake(frame.size.width*0.8,frame.size.height*0.9,31,30)];
        
            
        }

       
        [btn_cancel setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        [btn_cancel addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn_cancel];
        
        [self bringSubviewToFront:btn_cancel];
       ///s [self addSubview:receivedata];
        
    }
    
    return self;

}
-(void)Hideloader:(NSNotification *)notify
{
   
    
    [MBProgressHUD hideHUDForView:self animated:YES];
    
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                                     message:@"Successfully Done."
                                                    delegate:self
                                           cancelButtonTitle:@"ok"
                                           otherButtonTitles:nil];
    
    
    [alert show];

    
    
    
    
}

//-(void)targetMethod:(NSTimer *)timer
//{
//    //[timer invalidate];
//    [MBProgressHUD hideHUDForView:self animated:YES];
//    
//}

-(void)hideApplyCancel
{
    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    [csensor  counterUploadshuttr:YES UUID:self.UUIDD presetshutter:@"shutterMotor" on:NO];
   //FERHAT [MBProgressHUD showHUDAddedTo:self animated:YES];
   
    
    
   
    btn_apply.hidden=YES;
    btn_cancel.hidden=YES;
    lbl_apply.hidden=YES;
    lbl_cancel.hidden=YES;

}
-(void)readMotorValue:(int)vall
{
    
    [MBProgressHUD hideHUDForView:self animated:YES];
    if (vall>=6) {
        vall=6;
    }
  
    NSLog(@"readMotorValue %d",vall);
    [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",vall]]];
    blade_count=vall;

    
}
-(void)showApplyCancel{
    
    
   
    if ([self.old_new_preset isEqualToString:@"newpreset"]) {
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",1]]];
        blade_count=1;
    }
    else
    {
        int vallll=[self.prest.mottor intValue];
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",vallll]]];
        blade_count=vallll;
        

    
    }
    
    
    
    
    
    
    
   
    
    btn_apply.hidden=NO;
    btn_cancel.hidden=NO;
    lbl_apply.hidden=NO;
    lbl_cancel.hidden=NO;
    
}
-(void)readMOtor
{
      
}
-(void)recivedata:(id)sender{

    UIButton *btn=(UIButton *)sender;
    NSUserDefaults *defff=[NSUserDefaults standardUserDefaults];
    NSString *strr=[defff objectForKey:@"Michaeldata"];
    [btn setTitle:[NSString stringWithFormat:@"%@",strr] forState:UIControlStateNormal];



}
-(void)applypreset
{
   
    if ([self.old_new_preset isEqualToString:@"newpreset"]) {
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved_presets"];
        // if (data.length<1) {
        NSMutableArray *savedprst= [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:data error:nil];
        // }
        
       
       
            
            
            

        NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
        
        NSMutableDictionary *diccttt= [(NSMutableDictionary*)[userDeafult  objectForKey:@"NEWPRESET_DATA"]mutableCopy];
        BOOL isThere=NO;
        for (int i=0; i<savedprst.count; i++) {
            NSMutableArray *arrr=[savedprst objectAtIndex:i];
            if (arrr.count>0) {
                for (int kk=0; kk<arrr.count; kk++) {
                 Preset *  prest=(Preset*)[arrr objectAtIndex:0];
                    if ([prest.name isEqualToString:[diccttt valueForKey:@"name"]]) {
                        isThere=YES;
                        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                                                         message:@"You Already have a Preset with same name."
                                                                        delegate:self
                                                               cancelButtonTitle:@"ok"
                                                               otherButtonTitles: nil];
                        
                        
                        [alert show];
                        break;

                    }
                }
                
               
            }
            
        }
        if (isThere==NO) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.labelText = @"Loading.";
            
            [hud show:YES];

            [diccttt setObject:[NSString stringWithFormat:@"%d",blade_count] forKey:@"motor"];
            [diccttt setObject:self.UUIDD forKey:@"UUID"];
            [diccttt setObject:@"newpreset" forKey:@"NEWPREST"];
            
            csensor=[CustomSensor sharedCustomSensor];
            csensor.delegate=self;
            [csensor sendPresets:diccttt newPreset:@"newpreset"];
        }
        
    }
else if ([self.old_new_preset isEqualToString:@"oldpreset"])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.labelText = @"Loading.";
        
        [hud show:YES];

        
        NSMutableDictionary *diccttt= [[NSMutableDictionary alloc]init];
        
        [diccttt setObject:self.prest.serial_number forKey:@"serialnum"];
        [diccttt setObject:self.prest.name forKey:@"name"];
        [diccttt setObject:self.prest.min forKey:@"min"];
        [diccttt setObject:self.prest.hour forKey:@"hour"];
        [diccttt setObject:self.prest.days forKey:@"days"];
        [diccttt setObject:[NSString stringWithFormat:@"%d",blade_count] forKey:@"motor"];
        [diccttt setObject:self.prest.uuid_device forKey:@"UUID"];
        
        [diccttt setObject:@"oldpreset" forKey:@"NEWPREST"];
        csensor=[CustomSensor sharedCustomSensor];
        csensor.delegate=self;
        [csensor sendPresets:diccttt newPreset:@"oldpreset"];

    
    
    }


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self applypreset];
    }
}
-(void)applyBtnPressed:(id)sender
{
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                                     message:@"Apply to Preset!"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Apply", nil];
    
    
    [alert show];

    


    if([self.delegate respondsToSelector:@selector(applyBtnShutterBGSelected:indxx:)])
    {
     
        
    }

    NSLog(@"apply btn pressed");

}
-(void)cancelBtnPressed:(id)sender
{
    if([self.delegate respondsToSelector:@selector(cancelBtnShutterBGSelected:indxx:)])
    {
        [self.delegate cancelBtnShutterBGSelected:@"preset" indxx:1];
        
    }
    NSLog(@"cancel btn pressed");

}
-(void)upMoveStop:(id)sender
{
   
    
    //for (int i=0; i<self.blade_array.count; i++) {
      ++blade_count;
     NSLog(@"the balddeeeeee is %d",blade_count);
    if (blade_count<0){
       
        blade_count=0;
    }
    if (blade_count>6){
        
        blade_count=6;
    }
    if (blade_count>=0 && blade_count<7) {
        
      //  if (PRESET==NO) {
            
        
        if ([self.delegate respondsToSelector:@selector(movingShutterMovementUp:)])
         {
             [self.delegate movingShutterMovementUp:[NSString stringWithFormat:@"%d",blade_count]];
         }
       // }
        
         self.blade_img.image=nil;
         [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",blade_count]]];
        NSLog(@"blade countt %d",blade_count);
        
        
     }
    
//[UIImage imageNamed:@"blade_2.png"]
//    NSString *imgName = [self.blade_img image].accessibilityIdentifier;
//    NSLog(@"blade number%d",blade_count);

  //  [timer invalidate];
//    
//    shuttr0=(ShutterView *)[blindArr objectAtIndex:0];
//    shuttr1=(ShutterView *)[blindArr objectAtIndex:1];
//    shuttr2=(ShutterView *)[blindArr objectAtIndex:2];
//    shuttr3=(ShutterView *)[blindArr objectAtIndex:3];
//    shuttr4=(ShutterView *)[blindArr objectAtIndex:4];/////////////////////////////////////
//    
//    deltaAngle=0.3;
//    if (startTransform.c<0)
//    {
//        
//        startTransform.c=.3;
//        
//    }
//
//    if (startTransform.c>0 && startTransform.c<.9) {
//        
//        
//        startTransform=shuttr0.transform;
//        shuttr0.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        shuttr1.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        shuttr2.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        shuttr3.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        shuttr4.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        startTransform=shuttr0.transform;
//        NSLog(@"startTransform cccc %f",startTransform.c);
//    
//    }
}
-(void)moveUpButton:(id)sender
{
    ++blade_count;
  NSLog(@"the bladdeeeeee is %d",blade_count);
    if (blade_count<0) {
        blade_count=0;
        
    }
    if (blade_count>6){
        
        blade_count=6;
    }
    if (blade_count>=0 && blade_count<7) {
     // if (PRESET==NO)
     // {  self.blade_img.image=nil;
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",blade_count]]];
   // }
    }

    
//    shuttr0=(ShutterView *)[blindArr objectAtIndex:0];
//    shuttr1=(ShutterView *)[blindArr objectAtIndex:1];
//    shuttr2=(ShutterView *)[blindArr objectAtIndex:2];
//    shuttr3=(ShutterView *)[blindArr objectAtIndex:3];
//    shuttr4=(ShutterView *)[blindArr objectAtIndex:4];
    
//    deltaAngle=0.4;
//    if (startTransform.c<0)
//    {
//        
//        startTransform.c=.3;
//        
//    }
//
//       if (startTransform.c>0 && startTransform.c<.9)  {
//        
//        startTransform=shuttr0.transform;
//        shuttr0.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        shuttr1.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        shuttr2.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        shuttr3.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        shuttr4.transform = CGAffineTransformRotate(startTransform,-deltaAngle);
//        startTransform=shuttr0.transform;
//           
//           
//        NSLog(@"startTransform cccc %f",startTransform.c);
//        
//        
//    }
//    
    
}

-(void)upMove:(id)sender
{
    
    //timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveUpButton:)  userInfo:nil repeats:YES];

}

-(void)moveDownPress:(id)sender
{
    
    --blade_count;
     NSLog(@"the balddeeeeee is %d",blade_count);
    if (blade_count>7) {
        blade_count=7;
    }
    
    if (blade_count<0) {
        blade_count=1;
    }
    // NSLog(@"blade number%d",blade_count);
    //for (int i=0; i<self.blade_array.count; i++) {
    if (blade_count>=0 && blade_count<7) {
      //  if (PRESET==NO){
        self.blade_img.image=nil;
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",blade_count]]];
//}
    }

   
    //[timer invalidate];
    //NSLog(@"startTransformdownMoveStop %f",shuttr0.transform.a);
//    shuttr0=(ShutterView *)[blindArr objectAtIndex:0];
//    shuttr1=(ShutterView *)[blindArr objectAtIndex:1];
//    shuttr2=(ShutterView *)[blindArr objectAtIndex:2];
//    shuttr3=(ShutterView *)[blindArr objectAtIndex:3];
//    shuttr4=(ShutterView *)[blindArr objectAtIndex:4];
//    deltaAngle=0.4;
//    
// if (startTransform.c>0)
// {
// 
//     startTransform.c=-.03;
// 
// }
//   if (startTransform.c>-.9 &&startTransform.c<0) {
//    
//        startTransform=shuttr0.transform;
//        
//        shuttr0.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        shuttr1.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        shuttr2.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        shuttr3.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        shuttr4.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        
//        startTransform=shuttr0.transform;
//        NSLog(@"startTransform cccc %f",startTransform.c);
//    
//    }

}

-(void)downMoveStop:(id)sender
{
    
//    csensor=[CustomSensor sharedCustomSensor];
//    csensor.delegate=self;
//    [csensor counterUpload];
    

    --blade_count;
    NSLog(@"the balddeeeeee is %d",blade_count);
    if (blade_count>6) {
        blade_count=6;
    }
    
    if (blade_count<0) {
        blade_count=0;
    }
    NSLog(@"blade number%d",blade_count);
    //for (int i=0; i<self.blade_array.count; i++) {
    if (blade_count>=0 && blade_count<7) {
      // if (PRESET==NO)
      // {
        if ([self.delegate respondsToSelector:@selector(movingShutterMovementDown:)])
        {
            [self.delegate movingShutterMovementDown:[NSString stringWithFormat:@"%d",blade_count]];
        }
     //  }
       self.blade_img.image=nil;
        [self.blade_img  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blade_%d",blade_count]]];
   
       
       }
//

 //  [timer invalidate];
//    
//    shuttr0=(ShutterView *)[blindArr objectAtIndex:0];
//    shuttr1=(ShutterView *)[blindArr objectAtIndex:1];
//    shuttr2=(ShutterView *)[blindArr objectAtIndex:2];
//    shuttr3=(ShutterView *)[blindArr objectAtIndex:3];
//    shuttr4=(ShutterView *)[blindArr objectAtIndex:4];
//    
//    deltaAngle=0.4;
//    if (startTransform.c>0)
//    {
//        
//        startTransform.c=-.03;
//        
//    }
//   // startTransform=shuttr0.transform;
//   if (startTransform.c>-.9 &&startTransform.c<0) {
//
//    
//        startTransform=shuttr0.transform;
//        shuttr0.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        shuttr1.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        shuttr2.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        shuttr3.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        shuttr4.transform = CGAffineTransformRotate(startTransform,deltaAngle);
//        startTransform=shuttr0.transform;
//
//        NSLog(@"startTransform cccc %f",startTransform.c);
//      
//    }

}

-(void)downMove:(id)sender
{
   // timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveDownPress:)  userInfo:nil repeats:YES];
    

    
}

-(void)didPanSlider:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state)
    {
        
        case UIGestureRecognizerStateBegan:
        {
            
            deltaAngle=0.0f;
            
            CGPoint currentlocation = [panGesture locationInView:self];
            //float deltaY =  [panGesture translationInView:self].y- [panGesture translationInView:self].x;
            
            //  NSLog(@"location in view %f",[touch locationInView:self].y);
            
            if (CGRectContainsPoint(btnUp.frame, currentlocation))
                {
                    float dx;
                    float dy = 0.0;
                
                    for (int i=0;i<[blindArr count]; i++) {
                    
                    ShutterView *shuttr=(ShutterView *)[blindArr objectAtIndex:i];
                    dx = currentlocation.x - shuttr.center.x;
                    dy = currentlocation.y - shuttr.center.y;
                    
                    deltaAngle = atan2(dy,dx);
                   
                    // 4 - Save current transform
                  
                    
                    startTransform = shuttr.transform;
                    shuttr.transform = CGAffineTransformMakeRotation(deltaAngle );
                    
                    
                    
                    
                }
                 
                    [btnCenter setFrame:CGRectMake(btnCenter.frame.origin.x,dy, btnCenter.frame.size.width, btnCenter.frame.size.height)];
                
            }
        }
    
    case UIGestureRecognizerStateChanged:
        {
            
            CGPoint currentlocation = [panGesture locationInView:self];
            if (CGRectContainsPoint(imgvArrow.frame, currentlocation))
            {
                
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
                
                if (deltaAngle>-.88 && deltaAngle<0.88){
                    
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
//                    
//                    if ([self.delegate respondsToSelector:@selector(movingShutterMovementDown:)])
//                    {
//                        [self.delegate movingShutterMovementDown:SHUTTER_DOWN];
//                    }
//                    
                    

                }
                else if (deltaAngle>.24 && deltaAngle<.27)
                {
                    if ([self.delegate respondsToSelector:@selector(movingShutterMovementCenter:)])
                    {
                       // [self.delegate movingShutterMovementCenter:@"center"];
                    }
                }
                else {
                    shuttr0.shadowimg.alpha = 1;
                    shuttr1.shadowimg.alpha =1;
                    shuttr2.shadowimg.alpha = 1;
                    shuttr3.shadowimg.alpha = 1;
                    shuttr4.shadowimg.alpha = 1;
                    
                    if ([self.delegate respondsToSelector:@selector(movingShutterMovementUp:)])
                    {
                       // [self.delegate movingShutterMovementUp:SHUTTER_UP];
                    }
                
                
                
                }
              
                NSLog(@"delta andgl %f",deltaAngle);


                
//                shuttr0.shadowimg.transform = CGAffineTransformMakeScale(.5*pt.x, 0.5 *pt.y);
//                shuttr1.shadowimg.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
//                shuttr2.shadowimg.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
//                shuttr3.shadowimg.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
//                shuttr4.shadowimg.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
//
               
            }
            
    }
    
        case UIGestureRecognizerStateEnded:
        {
           
                
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
