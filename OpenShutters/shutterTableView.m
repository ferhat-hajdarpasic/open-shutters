//
//  shutterTableView.m
//  OpenShutters
//
//  Created by Sharad Thapa on 01/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.


#import "shutterTableView.h"

@implementation shutterTableView
@synthesize delegate;
-(id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)])){
        
       
        //self.clipsToBounds = YES;
        
        self.arr_shutter=[[NSMutableArray alloc]init];
        self.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
        
        viewFrame=frame;
        
        [self setupTable];
        
        
        
    }
    
    return self;
    
}
-(void)setupTable
{
    NSLog(@"the view is %@",self.arr_shutter);

    tableShuttr=[[UITableView alloc]initWithFrame:CGRectMake(0,0,  viewFrame.size.width,  viewFrame.size.height) style:UITableViewStylePlain];
    [self addSubview:tableShuttr];
    tableShuttr.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
    tableShuttr.dataSource=self;
    tableShuttr.delegate=self;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    
    return 1;
    
}
#pragma  count value table cell  Methods
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [UIView new];
//
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.arr_shutter.count;
    
}
#pragma   table cell  height Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath   *)indexPath
{
    
    CGFloat kExpandedCellHeight = 100;
    //CGFloat kNormalCellHeight = 40;
    
    return kExpandedCellHeight;
    
}

#pragma   table cell  show detail Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"HistoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.backgroundColor=[UIColor colorWithRed:245.0f/255 green:245.0f/255 blue:245.0f/255 alpha:1];
    
    UILabel *lbl_shutr=[[UILabel alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width*0.2,10, 200, 30)];
    
    UILabel *lbl_shutr_subtitle=[[UILabel alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width*0.2,34, 200, 30)];
    
    //lbl_dev.textAlignment=NSTextAlignmentCenter;
    
    lbl_shutr_subtitle.text=[self.arr_shutter objectAtIndex:indexPath.row];
    lbl_shutr_subtitle.textColor=[UIColor darkGrayColor];
    [lbl_shutr_subtitle setFont:[UIFont fontWithName:@"Helvetica-bold" size:14.0f]];
    
    
    lbl_shutr.text=[self.arr_shutter objectAtIndex:indexPath.row];
    lbl_shutr.textColor=[UIColor darkGrayColor];
    [lbl_shutr setFont:[UIFont fontWithName:@"Helvetica-bold" size:16.0f]];
    
    [cell.contentView addSubview:lbl_shutr];
     [cell.contentView addSubview:lbl_shutr];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [cell.contentView addSubview:lbl_shutter_title];
    
    
    self.btn_hand=[UIButton buttonWithType:UIButtonTypeCustom];
    //[btnCenter setTitle:@"center" forState:UIControlStateNormal];
    [self.btn_hand setBackgroundImage:[UIImage imageNamed:@"hand.png"] forState:UIControlStateNormal];
    [self.btn_hand setFrame:CGRectMake(cell.contentView.frame.size.width*0.9,32,42,48)];
    [self.btn_hand setTitle:@"ON" forState:UIControlStateNormal];
    [self.btn_hand setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn_hand.layer setAnchorPoint:CGPointMake(0.5,0.5)];
    [self.btn_hand setHighlighted:YES];
    
    [self.btn_hand addTarget:self action:@selector(btn_onnn:) forControlEvents:UIControlEventTouchUpInside];
   
    // [self.btn_on setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    
    
    [cell.contentView addSubview:self.btn_hand];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
   
    
    if([self.delegate respondsToSelector:@selector(shuttrTableSelected:indxx:)])
    {
        [self.delegate shuttrTableSelected:@"shutterlist" indxx:1];
        
    }
}



@end
