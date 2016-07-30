//
//  NameShutterViewController.h
//  OpenShutters
//
//  Created by Sharad Thapa on 27/10/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomSensor.h"

@interface NameShutterViewController : UIViewController<CustomSensorDelegate>
{
    
    IBOutlet UITableView *table_shutter;
    IBOutlet UIView *view_nameHolder;
    AppDelegate* app;
    NSMutableArray *expandedCells;
    long selectedINedx;
    NSIndexPath *indxx;
    bool isselected;
    bool isTextFld;
    IBOutlet UIView *top_view;
    IBOutlet UIButton *btn_back;
    CGRect frame_orgnl;
    CGRect frame_orgnl2;
    IBOutlet UILabel *txt_room;
    IBOutlet UILabel *txt_shutter;
    NSDictionary *dictDevices;
    CustomSensor *csensor;
    NSMutableArray *arr_deviceNewName;
    NSIndexPath* selectedCellIndexPath;
    UIAlertController *myAlertController;
    NSMutableDictionary *dictionary_devices;
//    IBOutlet UITextField *fld_room;
//    IBOutlet UITextField *fld_shuter;
   
}

-(IBAction)menuBtnPressed:(id)sender;
-(IBAction)roomBtnPressed:(id)sender;
-(IBAction)shutterBtnPressed:(id)sender;
-(IBAction)confifrmBtnPressed:(id)sender;
-(IBAction)backBtnPressed:(id)sender;

@end
