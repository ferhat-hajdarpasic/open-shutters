//
//  ShutterPresetcrollerViewController.h
//  OpenShutters
//
//  Created by Sharad Thapa on 28/10/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "PresetView.h"
#import "CustomSensor.h"
#import "SideBarViewController.h"
#import "TimeViewController.h"
#import "ShutterView.h"
#import "ShutterBackgroundView.h"
#import "Macros.h"
#import "AppDelegate.h"
#import "CustomSensor.h"
#import "shutterTableView.h"
#import "PresetViewContoller.h"
#import "PresetDetailVC.h"
#import "ShuttrViewController.h"

@interface ShutterPresetcrollerViewController : UIViewController<UIScrollViewDelegate,iCarouselDataSource,iCarouselDelegate,PresetViewDelegate,CustomSensorDelegate,ShutterBackgroundViewDelegate,shuttrTableDelegate,PresetViewVCDelegate,shuttrViewVCDelegate,PresetDetailViewVCDelegate,TimeVCDelegate>
{
    
    NSMutableDictionary *dictionary_devices;

     IBOutlet UIView *top_view;
    CGRect orgFrmTime;
    IBOutlet UIPageControl *pgControll;
    UIScrollView *scroll_shutters;
    IBOutlet UILabel *lbl_title;
    IBOutlet UILabel *lbl_sub_title_1;
    IBOutlet UILabel *lbl_sub_title_2;
    IBOutlet UILabel *preset;
    IBOutlet UIButton *btnCancel;
    IBOutlet UIButton *btnBack;
    IBOutlet UILabel *lblCancel;
    IBOutlet UIView  *view_bottom;
    
    
    ShutterBackgroundView *ShutterBg;
    NSMutableArray *shutterViewArr;
    NSMutableArray *presetArr;
    NSMutableArray *shuttrArr;
    NSMutableArray *shuttrSubTitleArr;
    
    IBOutlet UIView *viewForContiner;
    NSMutableArray *shutterBackARR;
    UILabel *lbl_status;
    NSMutableArray *blindArr;
    NSString *preset_Back;
    
    BOOL isInside;
    // IBOutlet UILabel *lbl_preset_title;
    // IBOutlet UILabel *lbl_shutter_title;
    //IBOutlet UILabel *lbl_shutter_sub_title;
    IBOutlet UIButton *btn_shutter;
    IBOutlet UIButton *btn_preset;
    IBOutlet UIButton *btn_edit_apply;
    IBOutlet UILabel *lbl_edit_apply;
    NSString *shutterPresetLabel;
    BOOL isPresetSelected;
    
    NSMutableArray *presetArr_old;

}
-(IBAction)backBtnPressed:(id)sender;
-(IBAction)shutterBtnPressed:(id)sender;
-(IBAction)PresetBtnPressed:(id)sender;
-(IBAction)cancelTimerBtnPressed:(id)sender;
-(IBAction)applyEditBtnPressed:(id)sender;
-(IBAction)syncBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *container;


@end
