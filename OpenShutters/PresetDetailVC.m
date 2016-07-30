//
//  PresetDetailVC.m
//  OpenShutters
//
//  Created by Sharad Thapa on 02/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.


#import "PresetDetailVC.h"
#import "PresetTableCustomCell.h"
#import "PresetDetailTableCell.h"
#import "Macros.h"
#import "Preset.h"
@implementation PresetDetailVC
-(void)viewDidLoad {
    
    [super viewDidLoad];
    [self showData];
     switchStr=@"0";
    
    
}
-(void)showData
{
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([self.fromTimeView isEqualToString:@"fromTIME"]) {
        
        NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
        dictionary_devices=[(NSMutableDictionary *)[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
        
        table_preset.dataSource=self;
        table_preset.delegate=self;
        [table_preset reloadData];
        
        }
    
    else{
        
        
        table_preset.dataSource=self;
        table_preset.delegate=self;
        [table_preset reloadData];
    
    
    }
    
    
    

}
-(void)viewDidAppear:(BOOL)animated
{
    [self showData];
}



#pragma mark - IBACTION
-(IBAction)syncBtnPressed:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 4.0];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [btn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self showData];
    
    
    
}

-(IBAction)backBtnPressed:(id)sender
{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"closeSideBarNotify"
     object:self];
    
}
-(IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
-(BOOL)prefersStatusBarHidden {
    
    return YES;
    
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateSwitchAtIndexPath:(UISwitch *)aswitch
{
    
   
    UISwitch *mySosSwitch = (UISwitch *)aswitch;
    if (mySosSwitch.on)
    {
        switchStr=@"1";
    }
    else{
        switchStr=@"0";
        
    }
}

#pragma mark - custom sensor delegate


-(void)devicesFound:(NSMutableArray *)arrrr
{
    [self pairDevices:arrrr];
}
-(void)pairDevices:(NSMutableArray *)list
{
    dictionary_devices=[[[NSMutableDictionary alloc]init]mutableCopy];
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    app.array_devices=[[[NSMutableArray alloc]init]mutableCopy];
    app.array_devices=[list mutableCopy];
    dictionary_devices=[(NSMutableDictionary *)[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
    
    NSLog(@"the apparray is %@",app.array_devices);
    if (dictionary_devices.count>0) {
        
        for (int i=0; i<app.array_devices.count; i++) {
            
            if ([[dictionary_devices valueForKey:[app.array_devices objectAtIndex:i]] isEqualToString:@""]) {
                
                [dictionary_devices setObject:@"" forKey:[app.array_devices objectAtIndex:i]];
            }
        }
        
        [userDeafult setObject:dictionary_devices forKey:DevicesNamedList];
        [userDeafult synchronize];
        
        
    }
    else{
        
        for (int i=0; i<app.array_devices.count; i++) {
            
            [dictionary_devices setObject:@"" forKey:[app.array_devices objectAtIndex:i]];
            [userDeafult setObject:dictionary_devices forKey:DevicesNamedList];
            [userDeafult synchronize];
            
            
            
        }
        
        
    }
    
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    long countt=0;
    if ([self.fromTimeView isEqualToString:@"fromTIME"]) {
        countt=dictionary_devices.count;
    }
    else{
    
    
    countt= self.shuters_arr.count;
    }
    return  countt;
}
#pragma   table cell  show detail Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PresetDetailTableCell *cell = (PresetDetailTableCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[PresetDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    if (indexPath.row%2==1) {
        
        cell.contentView.backgroundColor=[UIColor colorWithRed:192.0/255.0 green:197.0/255.0  blue:196.0/255.0  alpha:1.0];
        
    }
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
    dictt=[[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
     if ([self.fromTimeView isEqualToString:@"fromTIME"]) {
         NSArray *arrrr= [dictt allKeys];
         
         //////// dictionary for shutter and room extraction
         NSString *strr=[dictt valueForKey:[arrrr objectAtIndex:indexPath.row]];
         
         
         
         
         if([strr isEqualToString:@""]){
                        // cell.selectionStyle=UITableViewCellSelectionStyleGray
             cell.lbl_shutter.text=[arrrr objectAtIndex:indexPath.row];
             cell.lbl_shuttr_loc.hidden=YES;
            
         }
         
         else{
             
             //cell.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
             NSMutableArray *items = (NSMutableArray *)[strr componentsSeparatedByString:@"-"];
             cell.lbl_shutter.text=[items objectAtIndex:0];
             cell.lbl_shuttr_loc.text=[items objectAtIndex:1];
              cell.lbl_shuttr_loc.hidden=NO;
             // cell.fld_room.hidden=YES;
             //cell.fld_shuter.hidden=YES;
             
         }

         
     }
     else{
    Preset *prest=[[Preset alloc]init];

    prest=[self.shuters_arr objectAtIndex:indexPath.row];
    NSString * name=[dictt valueForKey:prest.uuid_device];

    

    if([name isEqualToString:@""]){
        
        cell.lbl_shutter.text=prest.uuid_device;
        cell.lbl_shuttr_loc.hidden=YES;

    
    }
    
    else{
        
        NSMutableArray *items = (NSMutableArray *)[name componentsSeparatedByString:@"-"];
        cell.lbl_shutter.text=[items objectAtIndex:0];
        cell.lbl_shuttr_loc.text=[items objectAtIndex:1];
        //cell.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
      
        
    }
     }
    [cell.switchh setTag:indexPath.row];
    [cell.switchh setOn:NO];
    [cell.switchh addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([switchStr isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Open Shutter"
                              message:@"Please Activate The Shutter."
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        [alert show];

    }
    else{
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    NSString *UUUIIDD;
    NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
    dictt=[[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
    NSArray *arrrr= [dictt allKeys];
    
    //////// dictionary for shutter and room extraction
    NSString *strr=[dictt valueForKey:[arrrr objectAtIndex:indexPath.row]];
    

    
    if([strr isEqualToString:@""]){
        
        // cell.selectionStyle=UITableViewCellSelectionStyleGray;
        UUUIIDD =[arrrr objectAtIndex:indexPath.row];
        
        
        
    }
    
    else{
        
        //cell.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
        UUUIIDD = [[dictt allKeys] objectAtIndex:indexPath.row];
        
        
    }
   
    dictt=[[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
    
    
  if (![self.fromTimeView isEqualToString:@"fromTIME"]) {
      Preset *prest=[[Preset alloc]init];
      
      prest=[self.shuters_arr objectAtIndex:indexPath.row];
      NSString * name=[dictt valueForKey:prest.uuid_device];
      NSString * str1;
      NSString * str2;
      if([name isEqualToString:@""]){
          
          str1=prest.uuid_device;
          str2=@"";
          
      }
      
      else{
          
          NSMutableArray *items = (NSMutableArray *)[name componentsSeparatedByString:@"-"];
          str1=[items objectAtIndex:0];
          str2=[items objectAtIndex:1];
          
      }
      if([self.delegate respondsToSelector:@selector(presetDetailVCSelected:mssg2:shuttrName1:shuttrName2:preset:presetarr:UUID:)])
      {
          
          [self.delegate presetDetailVCSelected:self.preset mssg2:@"oldpreset" shuttrName1:str1  shuttrName2:str2 preset:prest presetarr:self.shuters_arr UUID:prest.uuid_device];
          
      }

      
  }
  else {
      NSString * str1;
      NSString * str2;
      if([strr isEqualToString:@""]){
          
          str1=[arrrr objectAtIndex:indexPath.row];
          str2=@"";
          
      }
      
      else{
          
          NSMutableArray *items = (NSMutableArray *)[strr componentsSeparatedByString:@"-"];
          str1=[items objectAtIndex:0];
          str2=[items objectAtIndex:1];
          
      }

      if([self.delegate respondsToSelector:@selector(presetDetailVCSelected:mssg2:shuttrName1:shuttrName2:preset:presetarr:UUID:)])
      {
          
          [self.delegate presetDetailVCSelected:self.preset mssg2:@"newpreset" shuttrName1:str1 shuttrName2:str2 preset:nil presetarr:self.shuters_arr  UUID:UUUIIDD];
          
      }

  
            }
    }
    
}


@end
