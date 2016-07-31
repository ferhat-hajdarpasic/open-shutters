//  NameShutterViewController.m
//  OpenShutters
//  Created by Sharad Thapa on 27/10/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.
#import "NameShutterViewController.h"
#import "NameShutterTableViewCell.h"
#import "SideBarViewController.h"
#import "ShutterPresetcrollerViewController.h"
#import "Macros.h"
#import "MBProgressHUD.h"
@interface NameShutterViewController ()
{
    
}
@end

@implementation NameShutterViewController

-(void)viewDidLoad{
    
    isTextFld=NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLoaderClock:) name:@"clockReadFinished" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:@"tableAftrRead" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableWrite) name:@"tableAftrWrite" object:nil];

    [[NSUserDefaults standardUserDefaults] setObject:@"Home" forKey:@"HomeName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
   
    [super viewDidLoad];
   
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    [userDeafult setObject:@"VISITED" forKey:FIRST_TIME_SCREEN];
    UIImage *imgae=[UIImage imageNamed:@"img1.png"];
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((imgae), 1.0)];

    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    [csensor counterUpload:NO UUID:@"" presetshutter:@"readDEV" on:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Reading Devices...";
    [hud show:YES];
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.menu_title=@"Name Shutters";
    expandedCells=[[NSMutableArray alloc]init];

    top_view.layer.shadowOffset = CGSizeMake(0, 1);
    top_view.layer.shadowRadius = 3;
    top_view.layer.shadowOpacity =.5;
    btn_back.hidden=YES;
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideBACK:) name:@"NAMESHUTTER_HIDE_BACK" object:nil];
   
    isselected=NO;
    selectedINedx=-1;
    selectedCellIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
   
    indxx=selectedCellIndexPath;
    table_shutter.backgroundColor=[UIColor clearColor];
    view_nameHolder.hidden=YES;
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
}

-(void)reloadTable:(NSNotification *)notify {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [table_shutter reloadData];
}

-(void)hideLoaderClock:(NSNotification *)notify {
   [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)loadclock {
    csensor=[CustomSensor sharedCustomSensor];
    csensor.delegate=self;
    [csensor counterUpload:NO UUID:@"" presetshutter:@"" on:YES];
}

-(void)reloadTableWrite {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [table_shutter reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
}

-(void)showBACK:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"NAMESHUTTER_SHOW_BACK"]) {
        NSLog(@"NAMESHUTTER_SHOW_BACK");
    }
}

-(void)hideBACK:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"NAMESHUTTER_HIDE_BACK"]) {
        NSLog(@"NAMESHUTTER_HIDE_BACK");
        btn_back.hidden=YES;
     }
}

-(void)pairDevices:(NSMutableArray *)list
{
    
    dictionary_devices=[[NSMutableDictionary alloc]init];
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    //[userDeafult  removeObjectForKey:DevicesNamedList];
    app.array_devices=[[NSMutableArray alloc]init];
    //app.array_devices=list;
        for (id obj in list) {
            if (![app.array_devices containsObject:obj]) {
                [app.array_devices addObject:obj];
            }
        }
    //cell.textLabel.text = [NSString stringWithFormat:@"%@",p.name];
    dictionary_devices=[(NSMutableDictionary *)[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
    NSLog(@"the apparray is %@",app.array_devices);
    [userDeafult setObject:app.array_devices forKey:@"DEVICES"];
    [userDeafult synchronize];
    if(dictionary_devices.count>0){
    
        
        for (int i=0; i<app.array_devices.count; i++) {
            
            
            if([[dictionary_devices valueForKey:[app.array_devices objectAtIndex:i]] isEqualToString:@""]) {
                
                [dictionary_devices setObject:@"" forKey:[app.array_devices objectAtIndex:i]];

            }
    else     if([dictionary_devices valueForKey:[app.array_devices objectAtIndex:i]]==nil){
            
            
            
                [dictionary_devices setValue:@"" forKey:[app.array_devices objectAtIndex:i]];

        
        
            }
           

}
        [userDeafult setObject:dictionary_devices forKey:DevicesNamedList];
        [userDeafult synchronize];
         //[table_shutter reloadData];
        }
    else{
        
        for (int i=0; i<app.array_devices.count; i++) {
            dictionary_devices=nil;
             dictionary_devices=[[NSMutableDictionary alloc]init];
//      //    NSMutableDictionary*   dict=[[[NSMutableDictionary alloc]init]mutableCopy];
            [dictionary_devices setObject:@"" forKey:[app.array_devices objectAtIndex:i]];
            [userDeafult setObject:dictionary_devices forKey:DevicesNamedList];
            [userDeafult synchronize];
            
            
            
            
        }
        
        
    }
    
   
    
    
}
#pragma mark - custom sensor delegate
-(void)devicesFound:(NSMutableArray *)arrrr
{
    [self pairDevices:arrrr];
}
#pragma mark - IBACTION
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
-(void)swipeleft:(id)sender
{
    ShutterPresetcrollerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShutterPresetcrollerViewController"];
    
    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
   
    [self presentViewController:vc animated:NO completion:nil];
    
}
-(BOOL)prefersStatusBarHidden{
    
    return YES;

}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)callSystemIDCommand
{



}
-(IBAction)confifrmBtnPressed:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Reading Devices...";
    [hud show:YES];
  
    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
  
    if (selectedINedx >= 0) {
        NameShutterTableViewCell *cell=(NameShutterTableViewCell *)[table_shutter cellForRowAtIndexPath:indxx];
        if ((cell.name.text.length > 0) && (cell.shutter_name.text.length > 0) && (isTextFld==YES)) {
            isTextFld=NO;
            NSArray *arrrr= [dictionary_devices allKeys];
            
            NSString *sensorInstrument=[arrrr objectAtIndex:selectedINedx];
            NSString *roomShuttr=[NSString stringWithFormat:@"%@-%@",cell.name.text,cell.shutter_name.text];
            [dictionary_devices enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSLog(@"%@->%@",key,obj);
                for (id element in app.array_devices) {
                    if ([sensorInstrument isEqualToString:key]) {
                        [dictionary_devices setValue:roomShuttr forKey:sensorInstrument];
                        NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:roomShuttr,sensorInstrument,sensorInstrument,@"uuid", nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"SYSTEMCommand" object:self userInfo:dict];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"Im on the main thread");
                        });
                        NSLog(@"elemennt ---- sensor elemnt %@ %@",key,sensorInstrument);
                    }
                }
                  selectedINedx = -1;
            }];
            
            [userDeafult setObject:dictionary_devices forKey:DevicesNamedList];
        } else {
            UIAlertController *myAlertController =
                [UIAlertController alertControllerWithTitle:@"Open Shutter"
                    message: @"Please fill the feilds!"
                    preferredStyle:UIAlertControllerStyleAlert];
            
            //Step 2: Create a UIAlertAction that can be added to the alert
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here, eg dismiss the alertwindow
                                     [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            //Step 3: Add the UIAlertAction ok that we just created to our AlertController
            [myAlertController addAction: ok];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            //Step 4: Present the alert to the user
            [self presentViewController:myAlertController animated:YES completion:nil];
        }
    } else {
        myAlertController = [UIAlertController alertControllerWithTitle:@"Open Shutter"
                                                                message: @"Please select a device!"
                                                         preferredStyle:UIAlertControllerStyleAlert];
        
        //Step 2: Create a UIAlertAction that can be added to the alert
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here, eg dismiss the alertwindow
                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
        //Step 3: Add the UIAlertAction ok that we just created to our AlertController
        [myAlertController addAction: ok];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //Step 4: Present the alert to the user
        [self presentViewController:myAlertController animated:YES completion:nil];

    }

}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    isTextFld=YES;
    NameShutterTableViewCell *cell=(NameShutterTableViewCell *)[table_shutter cellForRowAtIndexPath:indxx];
    cell.lbl_device.hidden=YES;
        
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NameShutterTableViewCell *cell=(NameShutterTableViewCell *)[table_shutter cellForRowAtIndexPath:indxx];
    if (textField==cell.fld_room)
    {
        cell.fld_room.text=@"";

    }
    else  if (textField==cell.fld_shuter)
    {
        
        cell.fld_shuter.text=@"";
        
    }

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range     replacementString:(NSString *)string {
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField;
{
    
    return YES;
    
    
}
-(IBAction)roomBtnPressed:(id)sender
{
    
   

}
-(IBAction)shutterBtnPressed:(id)sender
{
    txt_shutter.text=@"";
    [txt_shutter becomeFirstResponder];

}
-(IBAction)menuBtnPressed:(id)sender
{
   
    SideBarViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SideBarViewController"];
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:vc animated:NO completion:nil];
    

}

-(void)usernameTextFieldChangedROOM:(id)sender{
    
    NameShutterTableViewCell *cell = (NameShutterTableViewCell *)[table_shutter cellForRowAtIndexPath:indxx];
    cell.name.text = cell.fld_room.text;
        
}
-(void)usernameTextFieldChangedShutter:(id)sender{
    
    NameShutterTableViewCell *cell=(NameShutterTableViewCell *)[table_shutter cellForRowAtIndexPath:indxx];
    cell.shutter_name.text=cell.fld_shuter.text;
        
}

#pragma  count value table cell  Methods
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return dictionary_devices.count;
}

#pragma   table cell  height Methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath   *)indexPath
{
    
    CGFloat kExpandedCellHeight = 190;
    CGFloat kNormalCellHeigh = 60;

    if([expandedCells containsObject:indexPath])
    {
        if (selectedINedx==indexPath.row)
        {
            
            
         //   NSString *strr=[dictionary_devices valueForKey:[app.array_devices objectAtIndex:selectedINedx]];
            
            return kExpandedCellHeight;
            
        }
        else
        {
            
            return kNormalCellHeigh;
        
        }
   
    }
   
    
    else
        {
        
       
        return kNormalCellHeigh;
    
    }

}

#pragma   table cell  show detail Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NameShutterTableViewCell *cell = (NameShutterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (!cell) {
        
        cell = [[NameShutterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    }
    
    ////////
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    keyboardDoneButtonView.backgroundColor=[UIColor darkGrayColor];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    
    
    [[UIBarButtonItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                         [UIColor whiteColor], NSForegroundColorAttributeName,
                                                         [UIFont fontWithName:@"Arial" size:13.0], NSFontAttributeName, nil]
                                               forState:UIControlStateNormal];
    
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    cell.fld_room.layer.cornerRadius = 15.0f;
    
    cell.fld_shuter.layer.cornerRadius = 15.0f;

    cell.fld_room.inputAccessoryView=keyboardDoneButtonView;
    cell.fld_shuter.inputAccessoryView=keyboardDoneButtonView;
    UIColor *color_MobNUMBER = [UIColor whiteColor];
    cell.fld_room.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Room Name" attributes:@{NSForegroundColorAttributeName: color_MobNUMBER}];
    
    cell.fld_shuter.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Shutter Name" attributes:@{NSForegroundColorAttributeName: color_MobNUMBER}];

    [cell.fld_room addTarget:self action:@selector(usernameTextFieldChangedROOM:) forControlEvents:UIControlEventEditingChanged];
    [cell.fld_shuter addTarget:self action:@selector(usernameTextFieldChangedShutter:) forControlEvents:UIControlEventEditingChanged];
    
    [cell.fld_room setFrame:CGRectMake(cell.frame.size.width*0.3, cell.frame.size.height*0.5,100, 200)];
    
    
    cell.name.hidden=YES;
    cell.shutter_name.hidden=YES;
    //////////////////
    frame_orgnl=cell.fld_room.frame;
    frame_orgnl2=cell.fld_shuter.frame;
   

    cell.name.textAlignment=NSTextAlignmentCenter;
    cell.shutter_name.textAlignment=NSTextAlignmentCenter;
  
   
     NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
   
    cell.clipsToBounds = YES;
    
    NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
    dictt=[[userDeafult  objectForKey:DevicesNamedList]mutableCopy];
    NSArray *arrrr= [dictt allKeys];
   
    //////// dictionary for shutter and room extraction
    NSString *strr=[dictt valueForKey:[arrrr objectAtIndex:indexPath.row]];
    NSLog(@"strrrrr %@",strr);

    if([strr isEqualToString:@""]) {
        
        [cell.fld_room  setFrame:CGRectMake( cell.fld_room.frame.origin.x, cell.fld_room.frame.origin.y-100, cell.fld_room.frame.size.width, cell.fld_room.frame.size.height)];
        [cell.fld_shuter  setFrame:CGRectMake( cell.fld_room.frame.origin.x, cell.fld_room.frame.origin.y-100, cell.fld_room.frame.size.width, cell.fld_room.frame.size.height)];
        cell.backgroundColor=[UIColor colorWithRed:143.0F/255 green:143.0f/255 blue:143.0F/255 alpha:0.9];
        // cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.lbl_device.text=[arrrr objectAtIndex:indexPath.row];
        cell.name.hidden=NO;
        cell.shutter_name.hidden=NO;
        cell.fld_room.hidden=NO;
        cell.fld_shuter.hidden=NO;
        cell.lbl_device.textColor=[UIColor darkGrayColor];
        if([expandedCells containsObject:indexPath] && selectedINedx==indexPath.row)
        {
            cell.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
            [UIView animateWithDuration:0.5
                                      delay:0.1
                                    options: UIViewAnimationCurveEaseIn
                                 animations:^{
                                     
                                     cell.fld_room.frame=frame_orgnl;
                                     cell.fld_shuter.frame=frame_orgnl;
                                     
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];
        
        }
        
    }
    
    else{
        
        cell.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
        NSMutableArray *items = (NSMutableArray *)[strr componentsSeparatedByString:@"-"];
        cell.name.text=[items objectAtIndex:0];
        cell.shutter_name.text=[items objectAtIndex:1];
        // cell.fld_room.hidden=YES;
        //cell.fld_shuter.hidden=YES;
        cell.lbl_device.hidden=YES;
        cell.name.hidden=NO;
        cell.shutter_name.hidden=NO;

    }
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    indxx=indexPath;
    selectedINedx=indexPath.row;

    NameShutterTableViewCell *cell=(NameShutterTableViewCell *)[table_shutter cellForRowAtIndexPath:indxx];
    cell.backgroundColor=[UIColor colorWithRed:245.0F/255 green:245.0f/255 blue:245.0F/255 alpha:1];
    
    if ([expandedCells containsObject:indexPath]) {
        [expandedCells removeObject:indexPath];
    } else {
        [expandedCells addObject:indexPath];
        if (indexPath.row==0) {
            NSString *strr=[app.array_devices objectAtIndex:indexPath.row];
            NSMutableArray *items = [strr componentsSeparatedByString:@"-"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectWithServices" object:self userInfo:nil];
            if (items.count > 1) {
                txt_room.text=[items objectAtIndex:0];
                txt_shutter.text=[items objectAtIndex:1];
            } else {
                txt_room.text=[items objectAtIndex:0];
            }
         }
    }
    [table_shutter reloadData];
}

@end
