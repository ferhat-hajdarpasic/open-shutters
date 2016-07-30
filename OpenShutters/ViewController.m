


//  ViewController.m
//  OpenShutters
//
//  Created by Sharad Thapa on 27/10/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.
#import "ViewController.h"
#import "NameShutterViewController.h"
@interface ViewController ()
@end
@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tapp=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    tapp.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tapp];
    
    
}
-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)sendmail:(id)sender
{
    
    NSLog(@"the color sir edd");
    UIView *viewww = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 400)];
    [viewww setBackgroundColor:[UIColor redColor]];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    //navBar.backgroundColor=[UIColor blueColor];
    [navBar addSubview:viewww];

}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)swipeleft:(id)sender
{
    NameShutterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NameShutterViewController"];
    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:vc animated:NO completion:nil];
    
}

@end
