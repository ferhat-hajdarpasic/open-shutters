//
//  PresetDetailVC.h
//  OpenShutters
//
//  Created by Sharad Thapa on 02/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomSensor.h"
#import "Preset.h"
@protocol PresetDetailViewVCDelegate <NSObject>
-(void)presetDetailVCSelected:(NSString *)message mssg2:(NSString *)message2 shuttrName1:(NSString *)name1 shuttrName2:(NSString *)name2 preset:(Preset *)pprest presetarr:(NSMutableArray *)pres UUID:(NSString *)uniqueID;
@end
@interface PresetDetailVC : UIViewController<CustomSensorDelegate,UITableViewDataSource,UITableViewDelegate>{
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
    
    NSString *switchStr;
    NSMutableArray *shutters_arr;


}
-(IBAction)syncBtnPressed:(id)sender;
@property (nonatomic,strong)id <PresetDetailViewVCDelegate> delegate;
@property (nonatomic,strong)NSMutableArray *shuters_arr;
@property (nonatomic,strong)NSString *preset;
@property (nonatomic,strong)NSString *fromTimeView;
@end
