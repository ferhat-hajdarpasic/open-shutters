//
//  TimeViewController.h
//  OpenShutters
//
//  Created by Sharad Thapa on 30/10/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
//
#import "CustomSensor.h"
#import <UIKit/UIKit.h>
@protocol TimeVCDelegate <NSObject>
-(void)applyTimeVCSelected:(NSString *)message mssg2:(NSString *)message2  indxx:(int)ind;
@end
@interface TimeViewController : UIViewController<CustomSensorDelegate>
{
    IBOutlet UIView *time_View;
    IBOutlet UIButton *btn_0;
    IBOutlet UIButton *btn_1;
    IBOutlet UIButton *btn_2;
    IBOutlet UIButton *btn_3;
    IBOutlet UIButton *btn_4;
    IBOutlet UIButton *btn_5;
    IBOutlet UIButton *btn_6;
    IBOutlet UIView *days_View;
    IBOutlet UITextField *txtFld_name;
    IBOutlet  UISwitch*switchbtn;
    IBOutlet UILabel *lbl_newPreset;
    IBOutlet UIScrollView *scrolll;
    NSString *currentTime;
    NSMutableArray *daysInputArr;
     NSMutableArray *btn_days_arr;
    CustomSensor * csensor;
}
@property (nonatomic,strong)id <TimeVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *selectedDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) NSString *editOrNew;
@property (nonatomic,strong)NSMutableArray *edit_Preset_arr;

-(IBAction)pickerAction:(id)sender;
-(IBAction)switchBtnPressed:(id)sender;
-(IBAction)backBtnPressed:(id)sender;
-(IBAction)menuBtnPressed:(id)sender;
-(IBAction)daysBtnPressed:(id)sender;
- (IBAction)doneBtnPressed:(id)sender;
@end

//NSString *str=currentTime;  //is your str
//
//NSArray *items = [str componentsSeparatedByString:@":"];   //take the one array for split the
//
//NSString *hrrr=[items objectAtIndex:0];   //shows Description
//NSString *mininn=[items objectAtIndex:1];   //Shows Data
//
//NSLog(@"the days inputs arr %@",daysInputArr);
//NSString *BINARYstr;
