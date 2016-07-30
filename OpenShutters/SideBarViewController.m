//  SideBarViewController.m
//  OpenShutters
//  Created by Sharad Thapa on 27/10/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.
#import "SideBarViewController.h"
#import "TutorialViewController.h"
#import "NameShutterViewController.h"
#import "AppDelegate.h"
@interface SideBarViewController ()
{
    AppDelegate *app;
}
@end
@implementation SideBarViewController
- (void)viewDidLoad {
   
    [super viewDidLoad];
   
    
    UITapGestureRecognizer * tapp=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMenu:)];
    tapp.numberOfTapsRequired=1;
   
    [self.view addGestureRecognizer:tapp];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    lbl_title.text=app.menu_title;
    
}
-(void)viewWillAppear:(BOOL)animated{

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissSideBar:)
                                                 name:@"closeSideBarNotify"
                                               object:nil];

}
-(void)dismissSideBar:(NSNotification *) notification
{
    
    if ([[notification name] isEqualToString:@"closeSideBarNotify"])
    {
        NSLog(@"closeSideBarNotify");
    
        CATransition* transition = [CATransition animation];
        transition.duration = 0.4;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromTop;
        
        [self.view.window.layer addAnimation:transition forKey:kCATransition];

        [self dismissViewControllerAnimated:NO completion:nil];
    
    }
}
-(IBAction)nameShuttersBtnPressed:(id)sender
{
    if([app.menu_title isEqualToString:@"Name Shutters"]) {
        CATransition* transition = [CATransition animation];
        transition.duration = 0.4;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromTop;
        
        [self.view.window.layer addAnimation:transition forKey:kCATransition];
        
        [self dismissViewControllerAnimated:NO completion:nil];
       
        
    }

    else{
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"NAMESHUTTER_SHOW_BACK"
         object:self];
        
        NameShutterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NameShutterViewController"];
    
        [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.4;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromBottom;
        
        [self.view.window.layer addAnimation:transition forKey:kCATransition];
        
        [self presentViewController:vc animated:NO completion:nil];
    
    }
}

-(IBAction)howTheAppWorksBtnPressed:(id)sender
{
   
    TutorialViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:vc animated:NO completion:nil];
     
 
}
-(IBAction)restoreBtnPressed:(id)sender
{

    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Open Shutter" message: @"Are you sure to want to restore factory settings?" preferredStyle:UIAlertControllerStyleAlert];
    
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
-(void)dismissMenu:(id)sender
{
    
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
   
}
-(void)viewDidDisappear:(BOOL)animated{
   
  
    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
