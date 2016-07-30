//
//  ShuttrTableCell.h
//  OpenShutters
//
//  Created by Sharad Thapa on 02/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuttrTableCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *lbl_Shttr;
@property (nonatomic, retain) IBOutlet UILabel *lbl_Shttr_sub;
@property (nonatomic, retain) IBOutlet UILabel *lbl_device;
@property (nonatomic, retain) IBOutlet UIButton *btn_hand;

@end
