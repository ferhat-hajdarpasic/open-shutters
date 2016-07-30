//
//  SideBarViewController.h
//  OpenShutters
//
//  Created by Sharad Thapa on 27/10/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBarViewController :UIViewController
{
    IBOutlet UILabel *lbl_title;

}
-(IBAction)nameShuttersBtnPressed:(id)sender;
-(IBAction)howTheAppWorksBtnPressed:(id)sender;
-(IBAction)restoreBtnPressed:(id)sender;
@end
