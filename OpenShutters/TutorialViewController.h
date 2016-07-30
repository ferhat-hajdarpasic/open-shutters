
//  TutorialViewController.h
//  OpenShutters
//
//  Created by Sharad Thapa on 30/10/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iCarousel.h"
@interface TutorialViewController : UIViewController<iCarouselDataSource,iCarouselDelegate>
{
     IBOutlet UIView *top_view;
     IBOutlet UIPageControl *pg_control;

}
-(IBAction)backBtnPressed:(id)sender;
- (IBAction)doneBtnPressed:(id)sender;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSMutableArray *pageImages;
@end

