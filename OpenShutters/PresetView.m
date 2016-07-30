//
//  PresetView.m
//  OpenShutters
//
//  Created by Sharad Thapa on 05/11/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.


#import "PresetView.h"

@implementation PresetView
@synthesize numberOfItems,delegate,shuttrOfItems,img_array;
- (id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)])){
        
        IS_ON=NO;
        selectedIndxx=-1;
        //self.clipsToBounds = YES;
        numberOfItems=[[NSMutableArray alloc]init];
        shuttrOfItems=[[NSMutableArray alloc]initWithObjects:@"Window 1",@"Window 2",@"Window 3",@"Window 4", nil];
        img_array=[[NSMutableArray alloc]initWithObjects:@"img1.png",@"1.png",@"img1.png",@"1.png", nil];
       // numberOfItems=[[NSMutableArray alloc]initWithObjects:@"", nil];
       // shuttrOfItems=[[NSMutableArray alloc]initWithObjects:@"", nil];
        self.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
        viewFrame=frame;
        
       // self.backgroundColor=[UIColor whiteColor];
      
        
        //sunImg=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*0.09,frame.size.height*0.04,34,39)];
        //[sunImg setImage:[UIImage imageNamed:@"sun.png"]];
       // [self addSubview:sunImg];
        
        
        lbl_time=[[UILabel alloc]initWithFrame:CGRectMake(0,frame.size.height*0.8,frame.size.width,30)];
        lbl_time.text=@"Set For";
        lbl_time.textColor=[UIColor blackColor];
        [lbl_time setFont:[UIFont fontWithName:@"Helvetica-bold" size:12.0f]];
        lbl_time.textAlignment=NSTextAlignmentCenter;

        [self addSubview:lbl_time];
        
        lbl_time_title=[[UILabel alloc]initWithFrame:CGRectMake(0,frame.size.height*0.85,frame.size.width,30)];
        lbl_time_title.text=@"9:30 AM Today";
        lbl_time_title.textColor=[UIColor blackColor];
        [lbl_time_title setFont:[UIFont fontWithName:@"Helvetica-bold" size:12.0f]];
        lbl_time_title.textAlignment=NSTextAlignmentCenter;

        [self addSubview:lbl_time_title];
        
        NSLog(@"the view is presetview");
        
        self.layer.cornerRadius=15.0f;
        
        self.lbl_slash=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.42,frame.size.height*0.05,45,45)];
        self.lbl_slash.text=@"/";
        self.lbl_slash.textColor=[UIColor grayColor];
        [self.lbl_slash setFont:[UIFont fontWithName:@"Helvetica-bold" size:15.0f]];
        self.lbl_slash.textAlignment=NSTextAlignmentCenter;
        
        [self addSubview:self.lbl_slash];

        self.btn_on=[UIButton buttonWithType:UIButtonTypeCustom];
       
        
        [self.btn_on setFrame:CGRectMake(frame.size.width*0.35,frame.size.height*0.05,45,45)];
        [self.btn_on setTitle:@"ON" forState:UIControlStateNormal];
        [self.btn_on setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn_on.layer setAnchorPoint:CGPointMake(0.5,0.5)];
        [self.btn_on setHighlighted:YES];
        [self.btn_on addTarget:self action:@selector(btn_onnn:) forControlEvents:UIControlEventTouchUpInside];
       // [self.btn_on setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        
        [self addSubview:self.btn_on];
        
        ////// OFF
        self.btn_off=[UIButton buttonWithType:UIButtonTypeCustom];
        //[btnCenter setTitle:@"center" forState:UIControlStateNormal];
        [self.btn_off setHighlighted:YES];
        [self.btn_off setFrame:CGRectMake(frame.size.width*0.5,frame.size.height*0.05,45,45)];
        [self.btn_off setTitle:@"OFF" forState:UIControlStateNormal];
        [self.btn_off setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.btn_off.layer setAnchorPoint:CGPointMake(0.5,0.5)];
        [self.btn_off addTarget:self action:@selector(btn_offf:) forControlEvents:UIControlEventTouchUpInside];
        //[self.btn_off setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        
        [self addSubview:self.btn_off];
        
        
        
        ///////
//        self.btn_activatePreset=[UIButton buttonWithType:UIButtonTypeCustom];
//        //[btnCenter setTitle:@"center" forState:UIControlStateNormal];
//        
//        [self.btn_activatePreset setFrame:CGRectMake(frame.size.width*0.00,frame.size.height*0.00,45,45)];
//       
//        [self.btn_activatePreset.layer setAnchorPoint:CGPointMake(0.5,0.5)];
//        [self.btn_activatePreset addTarget:self action:@selector(activatePreset:) forControlEvents:UIControlEventTouchUpInside];
//        [self.btn_activatePreset setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
//        
//        [self addSubview:self.btn_activatePreset];
//
        
        
        //////
        
        
        
        [self setupTable];
       
    }
   
    return self;
    
}
-(void)activatePreset:(id)sender
{
    UIButton *button =(UIButton *)sender;
    if (button.isSelected)
    {
        [button setSelected:NO];
        //  btn_selceted=NO;
        [button setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        
        
    }
    else {
        [button setSelected:YES];
        //  btn_selceted=YES;
       
        [button setImage:[UIImage imageNamed:@"tick-2.png"] forState:UIControlStateNormal];
    }

    
}
-(void)btn_onnn:(id)sender
{
    
    
    
    UIButton *button =(UIButton *)sender;
    //[button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[self.btn_off setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    IS_ON=YES;
    
    tablePreset.backgroundColor=[UIColor colorWithRed:45.0F/255 green:45.0F/255 blue:45.0F/255 alpha:1];
    
    self.backgroundColor=[UIColor colorWithRed:45.0F/255 green:45.0F/255 blue:45.0F/255 alpha:1];
    
    [tablePreset reloadData];

}
-(void)btn_offf:(id)sender
{
    if (IS_ON==YES) {
        
          //[self.btn_on setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    else{
    
    // [self.btn_off setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    }
    
    
  

    
    IS_ON=NO;
    
   // UIButton *button =(UIButton *)sender;
    
   
    tablePreset.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
    self.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
    [tablePreset reloadData];

    
}
-(void)setupTable
{
    tablePreset=[[UITableView alloc]initWithFrame:CGRectMake(0, viewFrame.size.height*0.2,  viewFrame.size.width,  viewFrame.size.height*0.6) style:UITableViewStylePlain];
    [self addSubview:tablePreset];
    tablePreset.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
    tablePreset.dataSource=self;
    tablePreset.delegate=self;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
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
    
    
    return numberOfItems.count;

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
    
    UILabel *lbl_dev=[[UILabel alloc]initWithFrame:CGRectMake(24,10, 200, 30)];
    
    UILabel *lbl_shutr=[[UILabel alloc]initWithFrame:CGRectMake(24,34, 200, 30)];
    
    //lbl_dev.textAlignment=NSTextAlignmentCenter;
    
    lbl_dev.text=[numberOfItems objectAtIndex:indexPath.row];
    lbl_dev.textColor=[UIColor darkGrayColor];
    [lbl_dev setFont:[UIFont fontWithName:@"Helvetica-bold" size:14.0f]];
   
    
    lbl_shutr.text=[shuttrOfItems objectAtIndex:indexPath.row];
    lbl_shutr.textColor=[UIColor darkGrayColor];
    [lbl_shutr setFont:[UIFont fontWithName:@"Helvetica-bold" size:16.0f]];

    [cell.contentView addSubview:lbl_shutr];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [cell.contentView addSubview:lbl_dev];
   
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width*0.5,32,57,15)];
    NSString *strr=[img_array objectAtIndex:indexPath.row];
    [imgv setImage:[UIImage imageNamed:strr]];
    [cell.contentView addSubview:imgv];
    
    
    
    
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (selectedIndxx==indexPath.row) {
        /// cell.contentView.alpha=0.4;
    }
    else{
    
     ///cell.contentView.alpha=1.0;
    
    }
    
    if (IS_ON==YES) {
        
         cell.contentView.backgroundColor=[UIColor colorWithRed:45.0F/255 green:45.0F/255 blue:45.0F/255 alpha:1];
   
    }
    return cell;

    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    selectedIndxx=indexPath.row;
   
    if([self.delegate respondsToSelector:@selector(presetTableSelected:indxx:)])
    {
        [self.delegate presetTableSelected:@"preset" indxx:1];
    
    }
    
    [tablePreset reloadData];
   
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
