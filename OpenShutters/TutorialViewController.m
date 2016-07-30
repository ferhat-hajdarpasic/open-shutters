//  TutorialViewController.m
//  OpenShutters
//  Created by Sharad Thapa on 30/10/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.


#import "TutorialViewController.h"
#import "SideBarViewController.h"
#import "AppDelegate.h"
@interface TutorialViewController ()
{

    AppDelegate *app;

}
@end

@implementation TutorialViewController
@synthesize carousel;

-(void)viewDidLoad
{
    
    [super viewDidLoad];
   
    
    top_view.layer.shadowOffset = CGSizeMake(0, 1);
    top_view.layer.shadowRadius = 3;
    top_view.layer.shadowOpacity =.5;

    NSLog(@"tutuoorr");
    
    // Create the data model
    self.pageImages=[[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"p1.png"], [UIImage imageNamed:@"p2.png"], [UIImage imageNamed:@"p3.png"], [UIImage imageNamed:@"p4.png"],[UIImage imageNamed:@"p5.png"],nil];
    carousel.type = iCarouselTypeCoverFlow;
    carousel.dataSource=self;
    carousel.delegate=self;
    
    
    
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.menu_title=@"How the App Works";
    pg_control.numberOfPages=5;
    
    // Create page view controller

}
-(IBAction)menuBtnPressed:(id)sender
{
    SideBarViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SideBarViewController"];
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:vc animated:NO completion:nil];
    
}
-(IBAction)backBtnPressed:(id)sender
{
     [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"closeSideBarNotify"
     object:self];
   
    
}

-(IBAction)doneBtnPressed:(id)sender
{

    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"closeSideBarNotify"
     object:self];

}
#pragma mark -
#pragma mark iCarousel methods
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    
    return [_pageImages count];
}
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel1
{
 UIView *vv=(UIView *)[carousel1 itemViewAtIndex:carousel1.currentItemIndex];
pg_control.currentPage=carousel1.currentItemIndex;


}
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250.0f, 310.0f)];
        ((UIImageView *)view).image =[_pageImages objectAtIndex:index];
          
          
        }
    
    return view;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
