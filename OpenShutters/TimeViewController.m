//  TimeViewController.m
//  OpenShutters
//  Created by Sharad Thapa on 30/10/15.
//  Copyright © 2015 Sharad Thapa. All rights reserved.
#import "TimeViewController.h"
#import "SideBarViewController.h"
#import "AppDelegate.h"
#import "Macros.h"
#import "Preset.h"
#import "MBProgressHUD.h"
@interface TimeViewController ()
{
    AppDelegate *app;
    NSMutableArray*myArray;
}
@end
@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Hideloader:) name:@"PresetSuccess" object:nil];
    myArray = [[NSMutableArray alloc]
               initWithObjects:@"0", @"0", @"0",  @"0",@"0", @"0", @"0", @"0",
               nil];
    btn_days_arr = [[NSMutableArray alloc]
               initWithObjects:btn_0, btn_1, btn_2,  btn_3,btn_4, btn_5, btn_6,
               nil];

    daysInputArr=[[NSMutableArray alloc]init];
    scrolll.canCancelContentTouches=YES;
    
    if (IS_IPHONE) {
        
        scrolll.contentSize=CGSizeMake(self.view.frame.size.width, 600);
    
    }
    else if (IS_IPHONE_5){
        
        scrolll.contentSize=CGSizeMake(self.view.frame.size.width, 600);
    
    }
    else{
    
        // scrolll.contentSize=CGSizeMake(self.view.frame.size.width,);
    
    }
    //self.view.backgroundColor=[UIColor colorWithRed:91.0F/255 green:154.0f/255 blue:160.0F/255 alpha:1];
    [time_View.layer setCornerRadius:19.0f];
    time_View.layer.borderWidth = 1.0f;
    time_View.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [time_View.layer setMasksToBounds:YES];
   
    self.datePicker.backgroundColor = [UIColor clearColor];
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    self.datePicker.layer.cornerRadius = 20;
    switchbtn.onTintColor = [UIColor darkGrayColor];
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.menu_title=@"Presets";
    
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
    txtFld_name.inputAccessoryView=keyboardDoneButtonView;
  
    UIColor *color_MobNUMBER = [UIColor whiteColor];
    txtFld_name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name Goes Here" attributes:@{NSForegroundColorAttributeName:color_MobNUMBER}];
    
    // Do any additional setup after loading the view, typically from a nib
    if ([self.editOrNew isEqualToString:@"editPreset"]) {
        
        
        NSLog(@"edit array %@",self.edit_Preset_arr);
        if (self.edit_Preset_arr.count>0) {
            [self loadTimeDays:self.edit_Preset_arr];
        }
    }
}
-(void)Hideloader:(NSNotification *)notify
{
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                                     message:@"Successfully Done."
                                                    delegate:self
                                           cancelButtonTitle:@"ok"
                                           otherButtonTitles:nil];
    
    
    [alert show];
    
    
    
    
    
}


-(void)loadTimeDays:(NSMutableArray *)presets_arr {
    Preset *prest=(Preset *)[presets_arr objectAtIndex:0];
    NSLog(@"HOURRR AND MINN. days%@ %@ %@",prest.hour,prest.min,prest.days);
    NSDate *datte=[self.datePicker date];
    NSCalendar *calender=[NSCalendar currentCalendar];
    NSDateComponents * components=[calender components:(NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:datte];
    int minn=[prest.min intValue];
    int hrrrr=[prest.hour intValue];

    [components setMinute:minn];
    [components setHour:hrrrr];
    
    NSDate *newdate=[calender dateFromComponents:components];
    [self.datePicker setDate:newdate];
    [self.datePicker reloadInputViews];
    
    NSString *hex = prest.days;
    NSUInteger hexAsInt;
    [[NSScanner scannerWithString:hex] scanHexInt:&hexAsInt];
    NSString *binary = [NSString stringWithFormat:@"%@", [self toBinary:hexAsInt strLength:[hex length]]];
    
    int lenn=8-binary.length;
    for (int i=0; i<lenn; i++) {
      binary=[NSString stringWithFormat:@"%@%@",@"0",binary];
    }
    NSLog(@"binario %@",binary);
    NSLog(@"the binary days  is %@",binary);
    NSMutableArray *dayyyss=[[NSMutableArray alloc]init];
    for (int i=(int)binary.length-1; i>=0;i--) {
        NSString *substr=[binary substringWithRange:NSMakeRange(i, 1)];
        [dayyyss addObject:substr];
    }
    [self highlightDAYS:dayyyss];
}
-(NSString *)toBinary:(NSUInteger)input strLength:(int)length{
    if (input == 1 || input == 0){
        
        NSString *str=[NSString stringWithFormat:@"%u", input];
        return str;
    }
    else {
        NSString *str=[NSString stringWithFormat:@"%@%u", [self toBinary:input / 2 strLength:0], input % 2];
        if(length>0){
            int reqInt = length * 4;
            for(int i= [str length];i < reqInt;i++){
                str=[NSString stringWithFormat:@"%@%@",@"0",str];
            }
        }
        return str;
    }
}

-(void)highlightDAYS:(NSMutableArray *)days_arr {
    [days_arr removeLastObject];
    for ( int kk=0; kk < btn_days_arr.count; kk++) {
        UIButton * btnn=(UIButton *)[btn_days_arr objectAtIndex:kk];
        if ([[days_arr objectAtIndex:kk] integerValue]==0) {
            [btnn setSelected:NO];
            [btnn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnn setBackgroundImage:[UIImage imageNamed:@"gray-dot.png"] forState:UIControlStateNormal];
            [myArray replaceObjectAtIndex:btnn.tag withObject:@"0"];
        } else if ([[days_arr objectAtIndex:kk]integerValue]==1) {
            [btnn setSelected:YES];
            [btnn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnn setBackgroundImage:[UIImage imageNamed:@"red-dot.png"] forState:UIControlStateNormal];
            [myArray replaceObjectAtIndex:btnn.tag withObject:@"1"];
        }
    }
}

-(IBAction)doneClicked:(id)sender
{
    //NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField==txtFld_name)
    {
       // txtFld_name.text=@"";
        
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range     replacementString:(NSString *)string
{
    
    if (textField==txtFld_name)
    {
       
        lbl_newPreset.text=txtFld_name.text;
        
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    
    return YES;
    
    
}

- (IBAction)switchBtnPressed:(id)sender
{
    UISwitch *mySosSwitch = (UISwitch *)sender;
    
    if (mySosSwitch.on)
    {
        
         time_View.hidden = NO;
         days_View.hidden = NO;
         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"MySwitch"];
         //YES means sosBtn should be visible
         [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
       
        time_View.hidden = YES;
        days_View.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"MySwitch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    }

}
-(NSString *)gethex:(NSString *)strrr
{
    NSString * str = strrr;
    
    NSString * hexStr =[NSString stringWithFormat:@"%@",
                        [NSData dataWithBytes:[str cStringUsingEncoding:NSUTF8StringEncoding]
                                       length:strlen([str cStringUsingEncoding:NSUTF8StringEncoding])]];
    
    for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", @" ", nil])
        hexStr = [hexStr stringByReplacingOccurrencesOfString:toRemove withString:@""];
    
    //NSLog(@"gethex%@", hexStr);
    return hexStr;
    
}
-(int)scanValue:(NSString *)valll
{
    
    NSScanner* pScanner = [NSScanner scannerWithString: valll];
    unsigned int dayValue;
    [pScanner scanHexInt: &dayValue];
    return dayValue;
    
}
-(NSString *)toBinary:(NSUInteger)input strLenght:(int)length
{
    NSString *strrr;
    if (input==1|| input==0) {
        NSString *str=[NSString stringWithFormat:@"%lu",input];
        strrr=str;
    }
    else{
        NSString *str=[NSString stringWithFormat:@"%@%lu",[self toBinary:input/2 strLenght:0],input%2];
        if (length>0)
            {
            
                int reqint=length *4;
                for (int i=str.length; i<reqint; i++) {
                    str=[NSString stringWithFormat:@"%@%@",@"0",str];
                }
            }
        strrr=  str;
           
           }
    
    return  strrr;
}

- (IBAction)doneBtnPressed:(id)sender {
    NSString *str=currentTime;  //is your str
    NSArray *items = [str componentsSeparatedByString:@":"];   //take the one array for split the
    NSString *hrrr=[items objectAtIndex:0];   //shows Description
    NSString *mininn=[items objectAtIndex:1];   //Shows Data
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    arr=[[[myArray reverseObjectEnumerator]allObjects]mutableCopy];
    NSString *greeting = [arr componentsJoinedByString:@""];
    char *bin=(char *)[greeting UTF8String];
    char *a = bin;
    int num = 0;
    do {
        int b = *a=='1'?1:0;
        num = (num<<1)|b;
        a++;
    } while (*a);
    NSLog(@"%X\n", num);
    NSLog(@"%@",greeting);
    NSString * pos=@"3";

    if ([self.editOrNew isEqualToString:@"editPreset"]) {
        Preset *preset=(Preset *)[self.edit_Preset_arr objectAtIndex:0];
        NSMutableDictionary *diccttt= [[NSMutableDictionary alloc]init];
        
        //[diccttt setObject:preset.serial_number forKey:@"serialnum"];
        if ([txtFld_name.text isEqualToString:@""]) {
            [diccttt setObject:preset.name forKey:@"name"];
        } else {
            [diccttt setObject:txtFld_name.text forKey:@"name"];
        }
        
        [diccttt setObject:[NSString stringWithFormat:@"%@",mininn] forKey:@"min"];
        [diccttt setObject:[NSString stringWithFormat:@"%@",hrrr]  forKey:@"hour"];
        [diccttt setObject:[NSString stringWithFormat:@"%d",num] forKey:@"days"];
        [diccttt setObject:preset.mottor forKey:@"motor"];
        [diccttt setObject:preset.uuid_device forKey:@"UUID"];
        
        [diccttt setObject:@"oldpreset" forKey:@"NEWPREST"];
        csensor=[CustomSensor sharedCustomSensor];
        csensor.delegate=self;
        [csensor writePresets:diccttt newPreset:@"oldpreset"];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading...";
        [hud show:YES];
    } else {
        if ([txtFld_name.text isEqualToString:@""]) {
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                message:@"Please Fill The Name!"delegate:self
                                               cancelButtonTitle:@"ok"
                                               otherButtonTitles: nil];
            [alert show];
        } else if (![myArray containsObject:@"1"]) {
            UIAlertView * alert =[[UIAlertView alloc ]
                            initWithTitle:@"Open Shutter"
                            message:@"Please Select a day!"delegate:self
                            cancelButtonTitle:@"ok"
                            otherButtonTitles: nil];
            [alert show];
        } else {
            NSMutableDictionary *eventData = [[NSMutableDictionary alloc]init];
            [eventData setObject:txtFld_name.text forKey:@"name"];
            [eventData setObject:pos forKey:@"motor"];
            [eventData setObject:[NSString stringWithFormat:@"%@",hrrr] forKey:@"hour"];
            [eventData setObject:[NSString stringWithFormat:@"%@",mininn] forKey:@"min"];
            [eventData setObject:[NSString stringWithFormat:@"%d",num] forKey:@"days"];
            NSUserDefaults *defff=[NSUserDefaults standardUserDefaults];
            [defff setObject:eventData forKey:@"NEWPRESET_DATA"];
            [defff synchronize];
            if([self.delegate respondsToSelector:@selector(applyTimeVCSelected:mssg2:indxx:)]) {
                [self.delegate applyTimeVCSelected:@"fromTIME" mssg2:txtFld_name.text  indxx:1];
            }
        }
    }
}

-(IBAction)menuBtnPressed:(id)sender
{
    
    SideBarViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SideBarViewController"];
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:vc animated:NO completion:nil];
    
}
-(IBAction)backBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)pickerAction:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle =UIDatePickerModeTime;
    
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    
    [dateFormatter setDateFormat:@"HH:mm"];
     currentTime= [dateFormatter stringFromDate:self.datePicker.date];
    self.selectedDate.text =currentTime;


}
-(IBAction)daysBtnPressed:(id)sender
{
    
    
    UIButton *btn=(UIButton *)sender;
    if (btn.selected) {
        
        [btn setSelected:NO];
       
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"gray-dot.png"] forState:UIControlStateNormal];
        
        [myArray replaceObjectAtIndex:btn.tag withObject:@"0"];
        
    }
else
    {
        
        
        [btn setSelected:YES];
    
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"red-dot.png"] forState:UIControlStateNormal];
         [myArray replaceObjectAtIndex:btn.tag withObject:@"1"];

        
    }
    
    for (int i=1; i<8; i++) {
        
        
        if (btn.tag==1+i) {
        }
        
        
        
    }


}

@end
