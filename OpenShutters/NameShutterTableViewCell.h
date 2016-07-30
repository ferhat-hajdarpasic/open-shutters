//
//  NameShutterTableViewCell.h
//  OpenShutters
//
//  Created by Sharad Thapa on 28/10/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameShutterTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *lbl_device;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *shutter_name;
@property (nonatomic, retain)IBOutlet UITextField *fld_room;
@property (nonatomic, retain)IBOutlet UITextField *fld_shuter;


@end
