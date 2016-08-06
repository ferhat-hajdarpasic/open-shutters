//  ShuttrViewController.m
//  OpenShutters
//  Created by Sharad Thapa on 02/02/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.

#import "ShuttrViewController.h"
#import "ShuttrTableCell.h"
#import "Macros.h"
#import "MBProgressHUD.h"
@implementation ShuttrViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"shutterConnected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideBusyIndicator) name:@"WaveProcessFinished" object:nil];
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)showBusyIndicator:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = message;
    [hud show:YES];
}

- (void)hideBusyIndicator {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)waveButtonClicked:(id)sender {
    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    [csensor waveProcessStart];
    [self showBusyIndicator:@"Please Wait..."];
}

-(void)reloadTable {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [table_preset reloadData];
}

#pragma mark - custom sensor delegate

-(void)devicesFound:(NSMutableArray *)arrrr
{
    [self pairDevices:arrrr];
}

-(void)pairDevices:(NSMutableArray *)list {
    dictionary_devices=[[[NSMutableDictionary alloc]init]mutableCopy];
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    app.array_devices=[[[NSMutableArray alloc]init]mutableCopy];
    app.array_devices=[list mutableCopy];
    dictionary_devices=[(NSMutableDictionary *)[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
    
    if (dictionary_devices.count>0) {
        for (int i=0; i<app.array_devices.count; i++) {
            if ([[dictionary_devices valueForKey:[app.array_devices objectAtIndex:i]] isEqualToString:@""]) {
                [dictionary_devices setObject:@"" forKey:[app.array_devices objectAtIndex:i]];
            }
        }
        [userDeafult setObject:dictionary_devices forKey:DevicesNamedList];
        [userDeafult synchronize];
    } else {
        for (int i=0; i<app.array_devices.count; i++) {
            [dictionary_devices setObject:@"" forKey:[app.array_devices objectAtIndex:i]];
            [userDeafult setObject:dictionary_devices forKey:DevicesNamedList];
            [userDeafult synchronize];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
      NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
      dictionary_devices=[(NSMutableDictionary *)[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
     [table_preset reloadData];
    
}
-(IBAction)syncBtnPressed:(id)sender {
    [self showBusyIndicator:@"Please Wait..."];
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIButton *btn=(UIButton *)sender;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 4.0];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [btn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    [csensor counterUpload:NO UUID:@"" presetshutter:@"readDEV" on:YES];
 }

#pragma mark - IBACTION
-(IBAction)backBtnPressed:(id)sender
{
    
//    [self dismissViewControllerAnimated:NO completion:nil];
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"closeSideBarNotify"
//     object:self];
    
}
-(IBAction)doneClicked:(id)sender
{
    //NSLog(@"Done Clicked.");
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
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
}
-(IBAction)roomBtnPressed:(id)sender
{
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self hideBusyIndicator];

    return dictionary_devices.count;
    
}

#pragma   table cell  show detail Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideBusyIndicator];
    ShuttrTableCell *cell = (ShuttrTableCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
         cell = [[ShuttrTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
     }
    [self hideBusyIndicator];
    if (indexPath.row%2==1) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:192.0/255.0 green:197.0/255.0  blue:196.0/255.0  alpha:1.0];
    }
   
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    cell.clipsToBounds = YES;
    
    NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
    dictt=[[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
    NSArray *arrrr= [dictt allKeys];
    NSString *strr=[dictt valueForKey:[arrrr objectAtIndex:indexPath.row]];
    
    if([strr isEqualToString:@""]) {
        [self hideBusyIndicator];
        cell.lbl_device.hidden=NO;
        cell.lbl_device.text=[arrrr objectAtIndex:indexPath.row];
        cell.lbl_Shttr.hidden=YES;
        cell.lbl_Shttr_sub.hidden=YES;
        cell.lbl_device.textColor=[UIColor darkGrayColor];
    } else {
        NSMutableArray *items = (NSMutableArray *)[strr componentsSeparatedByString:@"-"];
        cell.lbl_Shttr.text=[items objectAtIndex:0];
        cell.lbl_Shttr_sub.text=[items objectAtIndex:1];
        cell.lbl_device.hidden=YES;
        cell.lbl_Shttr_sub.hidden=NO;
        cell.lbl_Shttr.hidden=NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *UUUIIDD;
    NSString *strr=[dictionary_devices valueForKey:[app.array_devices objectAtIndex:indexPath.row]];
    NSLog(@"strrrrr %@",strr);
    
    
    if([strr isEqualToString:@""]){
        
        UUUIIDD =[app.array_devices objectAtIndex:indexPath.row];
    }
    
    else{
        UUUIIDD = [[dictionary_devices allKeys] objectAtIndex:indexPath.row];
    }
    NSLog(@"CENSOR bRUSH %@",csensor.sensorTags);
    if([self.delegate respondsToSelector:@selector(shuttrTableVCSelected:mssg2:indxx:UUID:)])
    {
        [self.delegate shuttrTableVCSelected:[presetArr objectAtIndex:indexPath.row] mssg2:[shuttrArr objectAtIndex:indexPath.row] indxx:1 UUID:UUUIIDD];
        
        
    }
}


@end
