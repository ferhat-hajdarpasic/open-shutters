//
//  ShuttrViewController.h
//  OpenShutters
//
//  Created by Sharad Thapa on 02/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSensor.h"
#import "AppDelegate.h"
@protocol shuttrViewVCDelegate <NSObject>
-(void)shuttrTableVCSelected:(NSString *)message  mssg2:(NSString *)message2 indxx:(int)ind UUID:(NSString *)uniqueID;
@end

@interface ShuttrViewController : UIViewController<CustomSensorDelegate>
{
    IBOutlet UITableView *table_preset;
    IBOutlet UIView *view_nameHolder;
    AppDelegate* app;
    NSMutableArray *expandedCells;
    long selectedINedx;
    NSIndexPath *indxx;
    bool isselected;
    
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
    
    NSMutableArray *presetArr;
    NSMutableArray *shuttrArr;
}
-(IBAction)syncBtnPressed:(id)sender;
@property (nonatomic,strong)id <shuttrViewVCDelegate> delegate;

@end
