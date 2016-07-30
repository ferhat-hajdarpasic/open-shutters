//
//  PresetDetailTableCell.h
//  OpenShutters
//
//  Created by Sharad Thapa on 04/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresetDetailTableCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *lbl_shutter;
@property (nonatomic, retain) IBOutlet UILabel *lbl_shuttr_loc;
@property (nonatomic, retain) IBOutlet UIButton *hand;
@property (nonatomic, retain)IBOutlet UISwitch *switchh;
@end
