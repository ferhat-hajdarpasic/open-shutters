//
//  PresetViewContoller.h
//  OpenShutters
//
//  Created by Sharad Thapa on 02/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSensor.h"
#import "AppDelegate.h"
@protocol PresetViewVCDelegate <NSObject>
-(void)presetTableVCSelected:(NSMutableArray *)shutterOFPreset name:(NSString *)title editMotor:(NSString *)emtr;;
-(void)presetTableEditSelected:(NSMutableArray *)preset_arr name:(NSString *)namePreset isEDit:(NSString *)editing;
-(void)presetTableAddPreetSelected:(NSString *)message indxx:(int)ind;

@end


@interface PresetViewContoller : UIViewController<CustomSensorDelegate>
{
    
    int indxxxx;
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
    NSMutableArray *PrestNameArr;
    NSMutableArray *numberOfShutterArr;

    NSIndexPath* selectedCellIndexPath;
    UIAlertController *myAlertController;
    NSMutableDictionary *dictionary_devices;
    NSString *switchStr;

}
-(IBAction)syncBtnPressed:(id)sender;
-(IBAction)addPresetBtnPressed:(id)sender;
@property (nonatomic,strong)id <PresetViewVCDelegate> delegate;
@end
