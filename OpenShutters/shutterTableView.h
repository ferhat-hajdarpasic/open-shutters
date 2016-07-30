//
//  shutterTableView.h
//  OpenShutters
//
//  Created by Sharad Thapa on 01/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
#import <UIKit/UIKit.h>
@protocol shuttrTableDelegate <NSObject>
-(void)shuttrTableSelected:(NSString *)message indxx:(int)ind;
@end
@interface shutterTableView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableShuttr;
    CGRect viewFrame;
    UILabel *lbl_shutter_title;
    UILabel *lbl_shutter_Subtitle;
   
    
}
-(void)setupTable;
@property (nonatomic,strong)id <shuttrTableDelegate> delegate;
@property (nonatomic,retain)NSMutableArray * arr_shutter;
@property (nonatomic,retain)NSMutableArray * shuttrOfItems;
@property (nonatomic,retain)NSMutableArray * img_array;
@property (nonatomic,retain)UIButton * btn_hand;


@end
