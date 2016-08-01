//
//  PresetViewContoller.m
//  OpenShutters
//
//  Created by Sharad Thapa on 02/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//

#import "PresetViewContoller.h"
#import "PresetTableCustomCell.h"
#import "PresetDetailVC.h"
#import "TimeViewController.h"
#import "Macros.h"
#import "MBProgressHUD.h"
#import "Preset.h"
@implementation PresetViewContoller
-(void)viewDidLoad {
    [super viewDidLoad];
    switchStr=@"0";
    PrestNameArr=[[NSMutableArray alloc]init];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved_presets"];
    PrestNameArr= [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:data error:nil];
    
    if (PrestNameArr.count>0) {
        [table_preset reloadData];
    }
}

-(void)registerForReadPresetEndNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLoader) name:@"readPresetEND" object:nil];
}

-(void)hideLoader {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self registerForReadPresetEndNotification];
    
    numberOfShutterArr=[[NSMutableArray alloc]init];
    PrestNameArr=[[NSMutableArray alloc]init];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved_presets"];
    PrestNameArr= [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:data error:nil];
    
    if (PrestNameArr.count>0) {
        [table_preset reloadData];
    }
    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    [csensor readPreset:YES UUID:@"" presetshutter:@"READPRESET" on:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [hud show:YES];
}

#pragma mark - custom sensor delegate
-(void)loadPresets:(NSMutableArray *)presetsss
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    if (presetsss.count>0) {
        [PrestNameArr removeAllObjects];
        PrestNameArr=[presetsss mutableCopy];
        [table_preset reloadData];
        
        NSLog(@"Done Clicked.%@",PrestNameArr);
    }
  

}

-(void)devicesFound:(NSMutableArray *)arrrr
{
}

#pragma mark - IBACTION
-(IBAction)backBtnPressed:(id)sender
{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"closeSideBarNotify"
     object:self];
    
}
-(IBAction)addPresetBtnPressed:(id)sender
{
    if([self.delegate respondsToSelector:@selector(presetTableAddPreetSelected:indxx:)])
    {
     
        [self.delegate presetTableAddPreetSelected:@"inddss" indxx:1];
      
     }
}

-(IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
- (BOOL)prefersStatusBarHidden {
    
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
}
-(IBAction)roomBtnPressed:(id)sender
{

    
}
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
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectWithServices" object:self userInfo:nil];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [hud show:YES];

    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    [csensor readPreset:YES UUID:@"" presetshutter:@"READPRESET" on:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [PrestNameArr count];
}
#pragma   table cell  height Methods

#pragma   table cell  show detail Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PresetTableCustomCell *cell = (PresetTableCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (!cell) {
        
        cell = [[PresetTableCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    if (indexPath.row%2==1) {
      cell.contentView.backgroundColor=[UIColor colorWithRed:192.0/255.0 green:197.0/255.0  blue:196.0/255.0  alpha:1.0];
    }

    [cell.btn_edit addTarget:self action:@selector(editMethodCalled:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_edit setTag:indexPath.row];
    
    Preset *prest=[[Preset alloc]init];
    NSMutableArray *arrr=[PrestNameArr objectAtIndex:indexPath.row];
    if (arrr.count>0) {
        
    
    prest=(Preset*)[arrr objectAtIndex:0];
    cell.lbl_preset.text=prest.name;
    cell.lbl_numOfShttr.text=[NSString stringWithFormat:@"%lu Shutters",[[PrestNameArr objectAtIndex:indexPath.row] count]];
    
    }
        
        cell.clipsToBounds = YES;
    ////
    
    
    [cell.switchh setOn:NO];
    [cell.switchh addTarget:self action:@selector(switchMethodCalled:) forControlEvents:UIControlEventTouchUpInside];
    [cell.switchh setTag:indexPath.row];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([switchStr isEqualToString:@"1"]) {
        
    
    Preset *prest=[[Preset alloc]init];
    NSMutableArray *arrr=[PrestNameArr objectAtIndex:indexPath.row];
    prest=(Preset*)[arrr objectAtIndex:0];
    
    
    if([self.delegate respondsToSelector:@selector(presetTableVCSelected:name:editMotor:)])
    {
        [self.delegate presetTableVCSelected:[PrestNameArr objectAtIndex:indexPath.row] name:prest.name editMotor:@""];
        
    }
    }
    else{
    
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Open Shutter"
                              message:@"Please Activate The Preset."
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        [alert show];
        
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [PrestNameArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (void)switchMethodCalled:(UISwitch *)aswitch
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
-(void)editMethodCalled:(id)sender{
    
    UIButton *btnn=(UIButton *)sender;
    
     if ([switchStr isEqualToString:@"1"]) {
    Preset *prest=[[Preset alloc]init];
    NSMutableArray *arrr=[PrestNameArr objectAtIndex:btnn.tag];
    prest=(Preset*)[arrr objectAtIndex:0];
    
    if([self.delegate respondsToSelector:@selector(presetTableEditSelected:name:isEDit:)])
    {
        [self.delegate presetTableEditSelected:[PrestNameArr objectAtIndex:btnn.tag] name:prest.name isEDit:@"editPreset"];
        
    }
     }
     else
     {
         
         UIAlertView *alert = [[UIAlertView alloc]
                               initWithTitle:@"Open Shutter"
                               message:@"Please Activate The Preset."
                               delegate:nil
                               cancelButtonTitle:@"Ok"
                               otherButtonTitles:nil];
         [alert show];

     
     }
    
    
}

-(void)presetDetailVCSelected:(NSString *)message indxx:(int)ind
{
    
    
}



@end
