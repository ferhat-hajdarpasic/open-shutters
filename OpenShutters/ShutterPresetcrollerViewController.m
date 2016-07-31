//  ShutterPresetcrollerViewController.m
//  OpenShutters
//  Created by Sharad Thapa on 28/10/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
#define DEGREES_IN_RADIANS(x) (M_PI * x / 180.0);
#import "ShutterPresetcrollerViewController.h"
@interface ShutterPresetcrollerViewController ()
{
    CustomSensor *csensor;
    AppDelegate *app;
    NSMutableDictionary *dict_dev;
}
@end

@implementation ShutterPresetcrollerViewController
-(void)viewDidLoad{
    
    [super viewDidLoad];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeName"];
  
    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    //    [csensor counterUpload:NO UUID:@""];
    //    [csensor  lightGreenOff];
    /////
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.menu_title=@"Shutters";

    /////// get the data for SAVED DEVICES
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    dict_dev=[(NSMutableDictionary *)[userDeafult  dictionaryForKey:DevicesNamedList]mutableCopy];
    
    //viewForContiner.layer.cornerRadius = 15.0f; // if you like rounded corners
    view_bottom.layer.shadowOffset = CGSizeMake(0,-1);
    view_bottom.layer.shadowRadius = 3;
    view_bottom.layer.shadowOpacity = 0.5;

    top_view.layer.shadowOffset = CGSizeMake(0, 1);
    top_view.layer.shadowRadius = 3;
    top_view.layer.shadowOpacity =0.5;

    btnBack.hidden=YES;
    isPresetSelected=NO;
    btn_preset.layer.masksToBounds = YES;
    btn_preset.layer.cornerRadius=10.0f;
    btn_shutter.layer.cornerRadius=10.0f;
    btn_shutter.layer.masksToBounds = YES;
    shutterPresetLabel=@"Shutters";

    //lbl_preset_title.hidden=YES;
    //lbl_shutter_title.hidden=NO;
    //lbl_shutter_sub_title.hidden=NO;
    
    /////// arrays initlaization
    presetArr=[[NSMutableArray alloc]initWithObjects:@"Midday sun",@"Dads favourite",@"Morning",@"Night time", nil];
    shuttrArr=[[NSMutableArray alloc]initWithObjects:@"Living Room",@"Dining Room",@"Kitchen Room",@"Drawing Room", nil];
    
    //shuttrSubTitleArr=[[NSMutableArray alloc]initWithObjects:@"Window 1",@"Window 2",@"Window 3",@"Window 4", nil];
    presetArr_old=[[NSMutableArray alloc]init];
}
//#pragma mark -
//#pragma mark iCarousel methods
//-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
//{
//    
//    unsigned long countt=0;
//    if ([shutterPresetLabel isEqualToString:@"Shutters"])
//    {
//        countt=[shuttrArr count];
//        //countt=[dict_dev count];
//
//    }
//    else{
//        
//        countt=[presetArr count];
//    }
//    
//    return  countt;
//}
//-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel1
//{
//
//       UIView *vv=(UIView *)[carousel1 itemViewAtIndex:carousel1.currentItemIndex];
//   
//    if ([shutterPresetLabel isEqualToString:@"Presets"]){
//    
//        if ([vv isKindOfClass:[PresetView class]]) {
//       
//        PresetView *customView = (PresetView *)vv;
//        customView.layer.masksToBounds = YES;
//        customView.layer.cornerRadius = 15.0f; // if you like rounded corners
//        customView.layer.shadowOffset = CGSizeMake(1, 1);
//        customView.layer.shadowRadius = 1;
//        customView.layer.shadowOpacity = 0.5;
//        
//        lbl_preset_title.text=[presetArr objectAtIndex:carousel1.currentItemIndex];
//        NSLog(@"THE ITEM IS %@",[customView.numberOfItems objectAtIndex:carousel1.currentItemIndex]);
//        
//        
//        }
//    
//    }
//    
//    else if ([shutterPresetLabel isEqualToString:@"Shutters"]){
//    
//        if ([vv isKindOfClass:[ShutterBackgroundView class]]) {
//            
//            ShutterBackgroundView *customView = (ShutterBackgroundView *)vv;
//            customView.delegate=self;
//            customView.layer.masksToBounds = YES;
//            customView.layer.cornerRadius = 15.0f; // if you like rounded corners
//            customView.layer.shadowOffset = CGSizeMake(0, 0);
//            customView.layer.shadowRadius = 1;
//            customView.layer.shadowOpacity = 0.5;
//           
//            lbl_shutter_title.text=[shuttrArr objectAtIndex:carousel1.currentItemIndex];
//            lbl_shutter_sub_title.text=[shuttrSubTitleArr objectAtIndex:carousel1.currentItemIndex];
//            
//        }
//    }
//    
//    else if ([shutterPresetLabel isEqualToString:@"shuttersOfPreset"]){
//        
//        if([vv isKindOfClass:[ShutterBackgroundView class]]) {
//            
//            ShutterBackgroundView *customView = (ShutterBackgroundView *)vv;
//            customView.layer.masksToBounds = YES;
//            customView.layer.cornerRadius = 15.0f; // if you like rounded corners
//            customView.layer.shadowOffset = CGSizeMake(1, 1);
//            customView.layer.shadowRadius = 1;
//            customView.layer.shadowOpacity = 0.5;
//            // lbl_preset_title.text=[presetArr objectAtIndex:carousel1.currentItemIndex];
//            lbl_shutter_title.text=[shuttrArr objectAtIndex:carousel1.currentItemIndex];
//            lbl_shutter_sub_title.text=[shuttrSubTitleArr objectAtIndex:carousel1.currentItemIndex];
//            }
//    }
//
//}
//-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
//{
//    
//    //create new view if no view is available for recycling
//    if([shutterPresetLabel isEqualToString:@"Presets"]){
//   
//     
//
//    if(view == nil)
//    {
//        PresetView *vv;
//        //set up reflection view
//        if (IS_HEIGHT_4s) {
//            vv= (PresetView *)[[PresetView alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 250.0f,300.0f)];
//        }
//        else{
//       /Users/sharadthapa/Documents/sensortg/OpenShutters _latest/OpenShutters/NameShutterTableViewCell.h   vv= (PresetView *)[[PresetView alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 250.0f, 300.0f)];
//        }
//      
//        vv.layer.masksToBounds = YES;
//        vv.layer.cornerRadius = 15.0f; // if you like rounded corners
//        vv.layer.shadowOffset = CGSizeMake(1, 1);
//        vv.layer.shadowRadius = 1;
//        vv.layer.shadowOpacity = 0.5;
//
//        vv.numberOfItems=shuttrArr;
//        vv.delegate=self;
//        //[vv setupTable];
//        NSLog(@"the itm is %@",[presetArr objectAtIndex:0]);
//        
//        if(index==0){
//            
//            lbl_preset_title.text=[presetArr objectAtIndex:0];
//            
//        
//        }
//        view=vv;
//      }
//   }
//    
//   else if([shutterPresetLabel isEqualToString:@"Shutters"]){
//   
//       if(view == nil)
//       {
//           ShutterBackgroundView *vv2 ;
//           //set up reflection view
//           if (IS_HEIGHT_4s) {
//               
//           vv2 = (ShutterBackgroundView *)[[ShutterBackgroundView alloc] initWithFrame:CGRectMake(50.0f, 100.0f, 250.0f, 300.0f)];
//           
//           }
////    else{
//          
//          vv2 = (ShutterBackgroundView *)[[ShutterBackgroundView alloc] initWithFrame:CGRectMake(50.0f, 100.0f, 250.0f, 300.0f)];
//           
//        }
//           
//           vv2.delegate=self;
//           vv2.layer.masksToBounds = YES;
//           vv2.layer.cornerRadius = 15.0f; // if you like rounded corners
//           vv2.layer.shadowOffset = CGSizeMake(1,1);
//           vv2.layer.shadowRadius = 1;
//           vv2.layer.shadowOpacity = .5;
//           
//           if(index==0){
//               
//               lbl_shutter_title.text=[shuttrArr objectAtIndex:0];
//               lbl_shutter_sub_title.text=[shuttrSubTitleArr objectAtIndex:0];
//           
//           }
//           
//           view=vv2;
//           // view.layer.borderWidth=9.0f;
//           
//           //shuttersOfPreset
//           
//        }
//
//   }
//   
//   else if([shutterPresetLabel isEqualToString:@"shuttersOfPreset"]){
//       
//       
//       if (view == nil)
//       {
//           //set up reflection view
//           ShutterBackgroundView *vv2;
//            if (IS_HEIGHT_4s) {
//                vv2= (ShutterBackgroundView *)[[ShutterBackgroundView alloc] initWithFrame:CGRectMake(50.0f, 100.0f, 250.0f, 300.0f)];
//            }
//            else{
//            vv2= (ShutterBackgroundView *)[[ShutterBackgroundView alloc] initWithFrame:CGRectMake(50.0f, 100.0f, 250.0f, 300.0f)];
//            
//            }
//           
//          // vv2.alpha=0.1;
//           vv2.layer.masksToBounds = YES;
//           vv2.layer.cornerRadius = 15.0f; // if you like rounded corners
//           vv2.layer.shadowOffset = CGSizeMake(0, 0);
//           vv2.layer.shadowRadius = 1;
//           vv2.layer.shadowOpacity = 0.5;
//
//           if (index==0) {
//               
//              // lbl_preset_title.text=[presetArr objectAtIndex:0];
//               lbl_shutter_title.text=[shuttrArr objectAtIndex:0];
//               lbl_shutter_sub_title.text=[shuttrSubTitleArr objectAtIndex:0];
//
//           }
////           [UIView animateWithDuration:1
////                                 delay:0.1
////                               options: UIViewAnimationCurveEaseIn
////                            animations:^{
////                                vv2.alpha=1.0;
////                                
////                            }
////                            completion:^(BOOL finished){
////                            }];
//           vv2.transform = CGAffineTransformMakeScale(0.1, .1);
//           [UIView beginAnimations:nil context:nil];
//           [UIView setAnimationDuration:0.7];
//           [UIView setAnimationDelay:0.0];
//           [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//           
//           vv2.transform = CGAffineTransformMakeScale(1, 1);
//           
//           [UIView commitAnimations];
//           view=vv2;
//           // view.layer.borderWidth=9.0f;
//           
//           //shuttersOfPreset
//           }
//       }
//    
//
//    return view;
//}
-(void)viewDidAppear:(BOOL)animated {
    if ([shutterPresetLabel isEqualToString:@"Shutters"])
    {
        //              shutterTableView *vv2 = [[shutterTableView alloc] initWithFrame:CGRectMake(0, 0 , viewForContiner.frame.size.width*1.2, viewForContiner.frame.size.height*1.2)];
        //              vv2.tag=119;
        //              vv2.arr_shutter=shuttrArr;
        //              vv2.delegate=self;
        //              [viewForContiner addSubview:vv2];
       
        lbl_sub_title_2.text=@"Shutters in Range";
        lbl_sub_title_1.hidden=YES;
        ShuttrViewController *vc2=[self.storyboard instantiateViewControllerWithIdentifier:@"ShuttrViewController"];
      
        
        [self addChildViewController:vc2];
        //vc.delegate=self;
        vc2.delegate=self;
        vc2.view.frame =viewForContiner.frame;
        [self.view addSubview:vc2.view];
        [self.view bringSubviewToFront:top_view];
        [vc2 didMoveToParentViewController:self];
        
        
    }
    else{
        
        
    }
    


}
#pragma mark -
#pragma mark IBACTION methods
-(IBAction)syncBtnPressed:(id)sender
{
    

    UIButton *btn=(UIButton *)sender;

    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 4.0];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [btn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
    //    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
//      // btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//      //  btn.imageView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);
//        [btn setTransform:CGAffineTransformRotate(btn.transform,- M_PI*3)];
//    }
//     
//        completion:^(BOOL finished){
//        
//    
//    }];


}
-(IBAction)cancelTimerBtnPressed:(id)sender
{
    if ([shutterPresetLabel isEqualToString:@"Presets"] || [shutterPresetLabel isEqualToString:@"shuttersOfPreset"]) {
       
        TimeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TimeViewController"];
        [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        CATransition* transition = [CATransition animation];
        transition.duration = 0.4;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromBottom;
        [self.view.window.layer addAnimation:transition forKey:kCATransition];
        [self presentViewController:vc animated:NO completion:nil];
    
    }
    else{
    
        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Open Shutter" message: @"Cancel all changes?" preferredStyle:UIAlertControllerStyleAlert];
        
        //Step 2: Create a UIAlertAction that can be added to the alert
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Yes"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here, eg dismiss the alertwindow
                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"No"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here, eg dismiss the alertwindow
                                     [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        //Step 3: Add the UIAlertAction ok that we just created to our AlertController
        [myAlertController addAction: ok];
        [myAlertController addAction: cancel];
        //Step 4: Present the alert to the user
        [self presentViewController:myAlertController animated:YES completion:nil];
        
        

    
    }
    

}
-(IBAction)shutterBtnPressed:(id)sender
{
    
    for (UIView* b in viewForContiner.subviews)
    {
        [b removeFromSuperview];
    }
     //[csensor sendDataToPeripheral2];
    UIViewController *vc11 = [self.childViewControllers lastObject];
    [vc11.view removeFromSuperview];
    [vc11 removeFromParentViewController];
    lbl_sub_title_2.text=@"Shutters in Range";
    lbl_sub_title_1.hidden=YES;
    
    ShuttrViewController *vc2=[self.storyboard instantiateViewControllerWithIdentifier:@"ShuttrViewController"];
    //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [self addChildViewController:vc2];
        //vc.delegate=self;
    vc2.delegate=self;
    vc2.view.frame =viewForContiner.frame;
    
    [self.view addSubview:vc2.view];
    [self.view bringSubviewToFront:top_view];
    [self.view bringSubviewToFront:view_bottom];
    [vc2 didMoveToParentViewController:self];
        
  
    
    // viewForCaoursel.backgroundColor=[UIColor colorWithRed:39.0F/255 green:80.0f/255 blue:115.0f/255 alpha:1];
    btnBack.hidden=YES;
    app.menu_title=@"Shutters";
    isPresetSelected=NO;
    // lbl_preset_title.hidden=YES;lbl_shutter_title.hidden=NO;
    // lbl_shutter_sub_title.hidden=NO;
    [btn_preset setBackgroundImage:nil forState:UIControlStateNormal];
    [btn_preset setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_shutter setBackgroundImage:[UIImage imageNamed:@"name_goes_here_blue.png"] forState:UIControlStateNormal];
    [btn_shutter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[carousel reloadData];
    lbl_title.text=@"Shutters";
    shutterPresetLabel=@"Shutters";
    [btnCancel setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [btn_edit_apply setImage:[UIImage imageNamed:@"apply.png"] forState:UIControlStateNormal];
    [lbl_edit_apply setText:@"Apply"];
    [lblCancel setText:@"Cancel"];

}
-(IBAction)applyEditBtnPressed:(id)sender
{
   
    
    if ([shutterPresetLabel isEqualToString:@"Presets"]){
        
        app.menu_title=@"Edit Presets";
        //btnBack.hidden=NO;
        lbl_title.text=@"Edit Presets";
      //  lbl_shutter_title.hidden=NO;
      //  lbl_shutter_sub_title.hidden=NO;
        [lblCancel setText:@"Name & Time"];
        [btnCancel setImage:[UIImage imageNamed:@"name&time.png"] forState:UIControlStateNormal];
            
        shutterPresetLabel=@"shuttersOfPreset";
        [btn_edit_apply setImage:[UIImage imageNamed:@"apply.png"] forState:UIControlStateNormal];
        [lbl_edit_apply setText:@"Apply"];
        // lbl_title.text=@"PresetsShuttr";

       //  [carousel reloadData];
        [btnCancel setImage:[UIImage imageNamed:@"name&time.png"] forState:UIControlStateNormal];
        [lblCancel setText:@"Name & Time"];
        [lblCancel setFrame:CGRectMake(10, 40, 100, 200)];
       //lblCancel.hidden=YES;
        shutterPresetLabel=@"shuttersOfPreset";
    //    }
    }
    else  if ([shutterPresetLabel isEqualToString:@"Shutters"]){
    
        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Open Shutter" message: @"Apply changes to blinds?" preferredStyle:UIAlertControllerStyleAlert];
        
        //Step 2: Create a UIAlertAction that can be added to the alert
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Confirm"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here, eg dismiss the alertwindow
                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here, eg dismiss the alertwindow
                                     [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        
        //Step 3: Add the UIAlertAction ok that we just created to our AlertController
        [myAlertController addAction: ok];
        [myAlertController addAction: cancel];
        //Step 4: Present the alert to the user
        
        [self presentViewController:myAlertController animated:YES completion:nil];
        

    
    }
    else  if([shutterPresetLabel isEqualToString:@"shuttersOfPreset"]){
               UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Open Shutter" message: @"Apply changes to Preset?" preferredStyle:UIAlertControllerStyleAlert];
        
        //Step 2: Create a UIAlertAction that can be added to the alert
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"Apply"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 btnBack.hidden=YES;
                                 app.menu_title=@"Presets";
                              //   lbl_preset_title.hidden=NO;
                               //  lbl_shutter_title.hidden=YES;
                             //    lbl_shutter_sub_title.hidden=YES;
                                 [btn_shutter setBackgroundImage:nil forState:UIControlStateNormal];
                                 [btn_shutter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                 [btn_preset setBackgroundImage:[UIImage imageNamed:@"name_goes_here.png"] forState:UIControlStateNormal];
                                 [btn_preset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                               
                                 // [carousel reloadData];
                                 
                                 lbl_title.text=@"Presets";
                                 shutterPresetLabel=@"Presets";
                                 [btnCancel setImage:[UIImage imageNamed:@"add_preset.png"] forState:UIControlStateNormal];
                                 [btn_edit_apply setImage:[UIImage imageNamed:@"ediit.png"] forState:UIControlStateNormal];
                                 [lblCancel setText:@"Add Preset"];
                                 [lbl_edit_apply setText:@"Edit"];

                                 //Do some thing here, eg dismiss the alertwindow
                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here, eg dismiss the alertwindow
                                     [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        
        //Step 3: Add the UIAlertAction ok that we just created to our AlertController
        [myAlertController addAction: ok];
        [myAlertController addAction: cancel];
        //Step 4: Present the alert to the user
        [self presentViewController:myAlertController animated:YES completion:nil];
        
        
        
    }

}
-(IBAction)PresetBtnPressed:(id)sender
{
    [csensor  lightGreenOff];
    for (UIView* b in viewForContiner.subviews)
    {
        [b removeFromSuperview];
    }

// [csensor sendDataToPeripheral];
//viewForCaoursel.backgroundColor=[UIColor colorWithRed:91.0F/255 green:154.0f/255 blue:160.0F/255 alpha:1];
    btnBack.hidden=YES;
    app.menu_title=@"Presets";
   // lbl_preset_title.hidden=NO;
  //  lbl_shutter_title.hidden=YES;
   // lbl_shutter_sub_title.hidden=YES;
    [btn_shutter setBackgroundImage:nil forState:UIControlStateNormal];
    [btn_shutter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_preset setBackgroundImage:[UIImage imageNamed:@"name_goes_here_blue.png"] forState:UIControlStateNormal];
    [btn_preset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // [carousel reloadData];
    lbl_title.text=@"Presets";
    shutterPresetLabel=@"Presets";
    [btnCancel setImage:[UIImage imageNamed:@"add_preset.png"] forState:UIControlStateNormal];
    [btn_edit_apply setImage:[UIImage imageNamed:@"ediit.png"] forState:UIControlStateNormal];
    [lblCancel setText:@"Add Preset"];
    [lbl_edit_apply setText:@"Edit"];
    UIViewController *vc11 = [self.childViewControllers lastObject];
    [vc11.view removeFromSuperview];
    [vc11 removeFromParentViewController];
    lbl_sub_title_1.hidden=YES;
    lbl_sub_title_2.text=@"Select a preset to edit the shutters within it";
    PresetViewContoller *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PresetViewContoller"];
    
    //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
   
    [self addChildViewController:vc];
    vc.delegate=self;
    vc.view.frame =viewForContiner.frame;
    [self.view addSubview:vc.view];
    [self.view bringSubviewToFront:top_view];
    [self.view bringSubviewToFront:view_bottom];
    [vc didMoveToParentViewController:self];
    
}
-(IBAction)backBtnPressed:(id)sender
{
    [csensor  lightGreenOff];
    if ([preset_Back isEqualToString:@"TimeVc"]){
        
        UIViewController *vc2 = [self.childViewControllers lastObject];
        [vc2.view removeFromSuperview];
        [vc2 removeFromParentViewController];
        btnBack.hidden=YES;
        lbl_sub_title_1.hidden=YES;
        lbl_title.text=@"Presets";
        lbl_sub_title_2.text=@"Select a preset to edit the shutters within it";
        
        PresetViewContoller *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PresetViewContoller"];
        
        //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        
        [self addChildViewController:vc];
        vc.delegate=self;
        vc.view.frame =viewForContiner.frame;
        [self.view addSubview:vc.view];
         [self.view bringSubviewToFront:top_view];
        
        [self.view bringSubviewToFront:view_bottom];
        [vc didMoveToParentViewController:self];
        
    }
    else  if ([preset_Back isEqualToString:@"PRESETBLADES"]){
//        for (UIView* b in viewForContiner.subviews)
//        {
//            [b removeFromSuperview];
//        }
//
     // [viewForContiner.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        btnBack.hidden=NO;
        preset_Back=@"TimeVc";
        lbl_sub_title_1.hidden=YES;
        lbl_sub_title_2.text=@"Tap a shuter to edit it";
        PresetDetailVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PresetDetailVC"];
        //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        [self addChildViewController:vc];
        vc.shuters_arr=presetArr_old;
        vc.fromTimeView=@"fromTIME";
        vc.delegate=self;
        vc.view.frame =viewForContiner.frame;
        
        [self.view addSubview:vc.view];
        [self.view bringSubviewToFront:top_view];
        [self.view bringSubviewToFront:view_bottom];
        [vc didMoveToParentViewController:self];

    }
    else if([preset_Back isEqualToString:@"SHUTTERBLADES"]){
       
        for (UIView* b in viewForContiner.subviews)
        {
            [b removeFromSuperview];
        }
        
        btnBack.hidden=YES;
        lbl_sub_title_2.text=@"Shutters in Range";
        lbl_sub_title_1.hidden=YES;
 
        ShuttrViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ShuttrViewController"];
        
        //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        
        [self addChildViewController:vc];
        vc.delegate=self;
        vc.view.frame =viewForContiner.frame;
        [self.view addSubview:vc.view];
         [self.view bringSubviewToFront:top_view];
          [self.view bringSubviewToFront:view_bottom];
        [vc didMoveToParentViewController:self];
        
        
    }

    
   
//btnBack.hidden=YES;
//app.menu_title=@"Presets";
//lbl_preset_title.hidden=NO;
//lbl_shutter_title.hidden=YES;
//  lbl_shutter_sub_title.hidden=YES;
//    [btn_shutter setBackgroundImage:nil forState:UIControlStateNormal];
//    [btn_shutter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn_preset setBackgroundImage:[UIImage imageNamed:@"name_goes_here.png"] forState:UIControlStateNormal];
//    [btn_preset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //[carousel reloadData];
//    lbl_title.text=@"Presets";
//    shutterPresetLabel=@"Presets";
//    [btnCancel setImage:[UIImage imageNamed:@"add_preset.png"] forState:UIControlStateNormal];
//    [btn_edit_apply setImage:[UIImage imageNamed:@"ediit.png"] forState:UIControlStateNormal];
//    [lblCancel setText:@"Add Preset"];
//    [lbl_edit_apply setText:@"Edit"];

    
    
}
-(IBAction)menuBtnPressed:(id)sender
{
    app.menu_title=lbl_title.text;
    SideBarViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SideBarViewController"];
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:vc animated:NO completion:nil];
    
}
#pragma mark -
#pragma mark preset table cell selection delegate
//-(void)presetFirstListSelected:(NSString *)message indxx:(int)ind
//{
//    for (UIView *subView in self.view.subviews)
//    {
//        if (subView.tag == 111)
//        {
//            [subView removeFromSuperview];
//        }
//    }
//    
//    
//    ShutterBackgroundView *vv2 = (ShutterBackgroundView *)[[ShutterBackgroundView alloc] initWithFrame:CGRectMake(0, 0 , viewForContiner.frame.size.width*1.2, viewForContiner.frame.size.height)];
//    
//    [viewForContiner addSubview:vv2];
//    
//
//
//
//}
-(void)presetTableVCSelected:(NSMutableArray *)shutterOFPreset name:(NSString *)title editMotor:(NSString *)emtr
{
    
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    lbl_sub_title_2.text=@"Tap a shuter to edit it";
    lbl_sub_title_1.hidden=YES;
    app.menu_title=@"Presets";
    btnBack.hidden=NO;
    lbl_title.text=title;
    preset_Back=@"TimeVc";
    
    PresetDetailVC *vc2=[self.storyboard instantiateViewControllerWithIdentifier:@"PresetDetailVC"];
    //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [self addChildViewController:vc2];
    vc2.preset=title;
    vc2.fromTimeView=@"";
    vc2.shuters_arr=shutterOFPreset;
    vc2.delegate=self;
    vc2.view.frame =viewForContiner.frame;
    [self.view addSubview:vc2.view];
     [self.view bringSubviewToFront:top_view];
      [self.view bringSubviewToFront:view_bottom];
    [vc2 didMoveToParentViewController:self];

}
-(void)presetTableEditSelected:(NSMutableArray *)preset_arr name:(NSString *)namePreset isEDit:(NSString *)editing;
{
    
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    preset_Back=@"TimeVc";
     btnBack.hidden=NO;
    app.menu_title=@"Edit Presets";
    //btnBack.hidden=NO;
    lbl_title.text=@"Presets";
    lbl_sub_title_2.text=namePreset;
    lbl_sub_title_1.hidden=YES;

    TimeViewController *vc2=[self.storyboard instantiateViewControllerWithIdentifier:@"TimeViewController"];
    
    //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    
    [self addChildViewController:vc2];
    vc2.delegate=self;
    vc2.editOrNew=editing;
    vc2.edit_Preset_arr=preset_arr;
    vc2.view.frame =viewForContiner.frame;
    [self.view addSubview:vc2.view];
    [self.view bringSubviewToFront:top_view];
    [self.view bringSubviewToFront:view_bottom];
    [vc2 didMoveToParentViewController:self];


}
-(void)presetTableAddPreetSelected:(NSString *)message indxx:(int)ind
{
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    btnBack.hidden=NO;
    app.menu_title=@"Presets";
    //btnBack.hidden=NO;
    
    lbl_title.text=@"Presets";
    lbl_sub_title_1.hidden=YES;
    lbl_sub_title_2.text=@"New Preset";
    TimeViewController *vc2=[self.storyboard instantiateViewControllerWithIdentifier:@"TimeViewController"];
     preset_Back=@"TimeVc";
    //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    
    [self addChildViewController:vc2];
    vc2.editOrNew=@"NO";
    vc2.view.frame =viewForContiner.frame;
    vc2.delegate=self;
    [self.view addSubview:vc2.view];
     [self.view bringSubviewToFront:top_view];
      [self.view bringSubviewToFront:view_bottom];
    [vc2 didMoveToParentViewController:self];

}
-(void)applyTimeVCSelected:(NSString *)message mssg2:(NSString *)message2 indxx:(int)ind
{
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    lbl_sub_title_2.text=@"Tap a shuter to edit it";
    lbl_sub_title_1.hidden=YES;
    app.menu_title=@"Presets";
    btnBack.hidden=NO;
    lbl_title.text=message2;
    preset_Back=@"TimeVc";

    btnBack.hidden=YES;
    
    
    PresetDetailVC *vcccc=[self.storyboard instantiateViewControllerWithIdentifier:@"PresetDetailVC"];
    
    //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    
    [self addChildViewController:vcccc];
    vcccc.delegate=self;
    vcccc.fromTimeView=message;
    vcccc.view.frame =viewForContiner.frame;
    [self.view addSubview:vcccc.view];
    [self.view bringSubviewToFront:top_view];
    [self.view bringSubviewToFront:view_bottom];
    [vc didMoveToParentViewController:self];

    
}
-(void)presetDetailVCSelected:(NSString *)message mssg2:(NSString *)message2 shuttrName1:(NSString *)name1 shuttrName2:(NSString *)name2 preset:(Preset *)pprest presetarr:(NSMutableArray *)pres UUID:(NSString *)uniqueID;

{
    
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    lbl_sub_title_1.hidden=NO;
    lbl_sub_title_2.hidden=NO;
    lbl_sub_title_1.text=name1;
    lbl_sub_title_2.text=name2;
    btnBack.hidden=NO;
    app.menu_title=@"Presets";
    preset_Back=@"PRESETBLADES";
    
    //viewForContiner=[[UIView alloc]initWithFrame:CGRectMake(10, 20, 200, 200)];
    ShutterBg = (ShutterBackgroundView *)[[ShutterBackgroundView alloc] initWithFrame:CGRectMake(0, 0 , viewForContiner.frame.size.width, viewForContiner.frame.size.height)];
    ShutterBg.UUIDD=uniqueID;
    ShutterBg.old_new_preset=message2;
    ShutterBg.prest=pprest;
  //  ShutterBg.preset_arrrr=pres;
    presetArr_old=[pres mutableCopy];
    [ShutterBg showApplyCancel];
    ShutterBg.delegate=self;
   [viewForContiner addSubview:ShutterBg];

}
#pragma mark -
#pragma mark shutterVC delegate
-(void)shuttrTableVCSelected:(NSString *)message  mssg2:(NSString *)message2 indxx:(int)ind UUID:(NSString *)uniqueID
{
    [[NSUserDefaults standardUserDefaults] setObject:uniqueID forKey:@"SaveCBPeripheral"];

    NSLog(@"THE uniqueID IS %@",uniqueID);
    ShutterBg.delegate=nil;
    [ShutterBg removeFromSuperview];
    lbl_sub_title_1.text=message2;
    lbl_sub_title_2.text=message;
    lbl_sub_title_1.hidden=NO;
  
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    btnBack.hidden=NO;
    preset_Back=@"SHUTTERBLADES";
   
    ShutterBg = (ShutterBackgroundView *)[[ShutterBackgroundView alloc] initWithFrame:CGRectMake(0, 0 , viewForContiner.frame.size.width, viewForContiner.frame.size.height)];
    ShutterBg.UUIDD=uniqueID;
   [ShutterBg hideApplyCancel];
    ShutterBg.delegate=self;
    [viewForContiner addSubview:ShutterBg];


}
-(void)shuttrTableSelected:(NSString *)message indxx:(int)ind
{
    preset_Back=@"BLADES";
    ShutterBackgroundView *vv2 = (ShutterBackgroundView *)[[ShutterBackgroundView alloc] initWithFrame:CGRectMake(0, 0 , viewForContiner.frame.size.width*1.2, viewForContiner.frame.size.height)];
    btnBack.hidden=NO;
    vv2.delegate=self;
    [viewForContiner addSubview:vv2];

}
#pragma mark -
#pragma mark SHUTTER BACKGRND VIEW delegate
-(BOOL)applyBtnShutterBGSelected:(NSString *)message indxx:(int)ind
{
  __block  BOOL STATUS=NO;
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:nil message: @"Apply changes to blinds?" preferredStyle:UIAlertControllerStyleAlert];
    
    //Step 2: Create a UIAlertAction that can be added to the alert
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             UIViewController *vc2 = [self.childViewControllers lastObject];
                             [vc2.view removeFromSuperview];
                             [vc2 removeFromParentViewController];
                             btnBack.hidden=NO;
                             preset_Back=@"TimeVc";
                             
                             lbl_sub_title_1.hidden=YES;
                             lbl_sub_title_2.text=@"Tap a shuter to edit it";
                             
//                             PresetDetailVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PresetDetailVC"];
//                             
//                             //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
//                             
//                             [self addChildViewController:vc];
//                             vc.delegate=self;
//                             vc.view.frame =viewForContiner.frame;
//                             [self.view addSubview:vc.view];
//                             [self.view bringSubviewToFront:top_view];
//                               [self.view bringSubviewToFront:view_bottom];
//                             [vc didMoveToParentViewController:self];
                             
                             
                             //Do some thing here, eg dismiss the alertwindow
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             STATUS=YES;
                         }];
    
    
        UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"No"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here, eg dismiss the alertwindow
                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                 STATUS=NO;

                             }];
    
    
    //Step 3: Add the UIAlertAction ok that we just created to our AlertController
    [myAlertController addAction: ok];
    [myAlertController addAction: cancel];
    //Step 4: Present the alert to the user
    
    [self presentViewController:myAlertController animated:YES completion:nil];

   //    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Open Shutter" message: @"Apply changes to blinds?" preferredStyle:UIAlertControllerStyleAlert];
//    
//    //Step 2: Create a UIAlertAction that can be added to the alert
//    UIAlertAction* ok = [UIAlertAction
//                         actionWithTitle:@"Confirm"
//                         style:UIAlertActionStyleDefault
//                         handler:^(UIAlertAction * action)
//                         {
//                             //Do some thing here, eg dismiss the alertwindow
//                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
//                             
//                         }];
//    
//    UIAlertAction* cancel = [UIAlertAction
//                             actionWithTitle:@"cancel"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 //Do some thing here, eg dismiss the alertwindow
//                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//    
//    
//    //Step 3: Add the UIAlertAction ok that we just created to our AlertController
//    [myAlertController addAction: ok];
//    [myAlertController addAction: cancel];
//    //Step 4: Present the alert to the user
//    
//    [self presentViewController:myAlertController animated:YES completion:nil];
    return  STATUS;
}

-(void)cancelBtnShutterBGSelected:(NSString *)message indxx:(int)ind
{
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:nil message:@"Are you sure you want to cancel your changes?" preferredStyle:UIAlertControllerStyleAlert];
    
    //Step 2: Create a UIAlertAction that can be added to the alert
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             UIViewController *vc2 = [self.childViewControllers lastObject];
                             [vc2.view removeFromSuperview];
                             [vc2 removeFromParentViewController];
                             btnBack.hidden=NO;
                             preset_Back=@"TimeVc";
                             lbl_sub_title_1.hidden=YES;
                             lbl_sub_title_2.text=@"Tap a shuter to edit it";
                             
                             
                             PresetDetailVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PresetDetailVC"];
                             
                             //[vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
                             
                             [self addChildViewController:vc];
                             vc.delegate=self;
                             vc.view.frame =viewForContiner.frame;
                             [self.view addSubview:vc.view];
                             [self.view bringSubviewToFront:top_view];
                               [self.view bringSubviewToFront:view_bottom];
                             [vc didMoveToParentViewController:self];

                             //Do some thing here, eg dismiss the alertwindow
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"No"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 //Do some thing here, eg dismiss the alertwindow
                        [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    //Step 3: Add the UIAlertAction ok that we just created to our AlertController
    [myAlertController addAction: ok];
    [myAlertController addAction: cancel];
    //Step 4: Present the alert to the user
    [self presentViewController:myAlertController animated:YES completion:nil];
    

//    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Open Shutter" message: @"Cancel all changes?" preferredStyle:UIAlertControllerStyleAlert];
//    
//    //Step 2: Create a UIAlertAction that can be added to the alert
//    UIAlertAction* ok = [UIAlertAction
//                         actionWithTitle:@"Yes"
//                         style:UIAlertActionStyleDefault
//                         handler:^(UIAlertAction * action)
//                         {
//                             //Do some thing here, eg dismiss the alertwindow
//                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
//                             
//                         }];
//    UIAlertAction* cancel = [UIAlertAction
//                             actionWithTitle:@"No"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 //Do some thing here, eg dismiss the alertwindow
//                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//    
//    //Step 3: Add the UIAlertAction ok that we just created to our AlertController
//    [myAlertController addAction: ok];
//    [myAlertController addAction: cancel];
//    //Step 4: Present the alert to the user
//    [self presentViewController:myAlertController animated:YES completion:nil];
    

//    UIViewController *vc = [self.childViewControllers lastObject];
//    [vc.view removeFromSuperview];
//    [vc removeFromParentViewController];
//
}
-(void)movingShutterMovementUp:(NSString *)data;
{
    NSLog(@"GREEN LIGHT ON");
    
     //[csensor lightRedOff];
    if (!csensor.isUP) {
       
        [csensor lightGreenOn:data];
    
    }
    
}
-(void)movingShutterMovementCenter:(NSString *)data
{
    NSLog(@"GREEN LIGHT ON");
    
   
}
-(void)movingShutterMovementDown:(NSString *)data {
    NSLog(@"RED LIGHT ON");
    if(!csensor.isUP) {
        [csensor lightGreenOn:data];
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
