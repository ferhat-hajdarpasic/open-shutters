//
//  PresetView.h
//  OpenShutters
//
//  Created by Sharad Thapa on 05/11/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PresetViewDelegate <NSObject>
-(void)presetTableSelected:(NSString *)message indxx:(int)ind;
@end

@interface PresetView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tablePreset;
    UIImageView *sunImg;
    CGRect viewFrame;
    UILabel *lbl_time_title;
    UILabel *lbl_time;
    int selectedIndxx;
    BOOL IS_ON;

}
-(void)setupTable;
@property (nonatomic,strong)id <PresetViewDelegate> delegate;
@property (nonatomic,retain)NSMutableArray * numberOfItems;
@property (nonatomic,retain)NSMutableArray * shuttrOfItems;
@property (nonatomic,retain)NSMutableArray * img_array;
@property (nonatomic,retain)UIButton * btn_activatePreset;
@property (nonatomic,retain)UIButton * btn_on;
@property (nonatomic,retain)UIButton * btn_off;
@property (nonatomic,retain)UILabel * lbl_slash;
@end
