//PresetTableCustomCell.h
//OpenShutters
//Created by Sharad Thapa on 02/02/16.
//Copyright © 2016 Sharad Thapa. All rights reserved.


#import <UIKit/UIKit.h>

@interface PresetTableCustomCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *lbl_preset;
@property (nonatomic, retain) IBOutlet UILabel *lbl_numOfShttr;
@property (nonatomic, retain) IBOutlet UIButton *btn_edit;
@property (nonatomic, retain)IBOutlet UISwitch *switchh;
@end
