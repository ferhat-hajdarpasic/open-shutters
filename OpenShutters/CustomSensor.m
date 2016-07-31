
//  VerifyMobile.m
//  Unninr
//  Created by Sharad Thapa on 23/04/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.


#import "CustomSensor.h"
#import "Macros.h"
#import "Preset.h"
#define FLAG_GYRO_Z 1 //000001
#define FLAG_GYRO_Y 2 //000010
#define FLAG_GYRO_X 4 //000100
#define FLAG_ACC_Z 8 //001000
#define FLAG_ACC_Y 16 //010000
#define FLAG_ACC_X 32 //100000
#define FLAG_MAG 64 //1000000
#define FLAG_WAKE_ON 128 //10000000=
//#define FLAG_WAKE_ON 128 //10000000
#define FLAG_ACC_RANGE_4G 256//100000000
#define FLAG_ACC_RANGE_8G 512//1000000000
#define FLAG_ACC_RANGE_16G 768//1100000000
// Accelerometer ranges
#define ACC_RANGE_2G      0
#define ACC_RANGE_4G      1
#define ACC_RANGE_8G      2
#define ACC_RANGE_16G     3
@implementation CustomSensor
int accRange = 0; 

#define UUID_HUM_SERV @"f000aa20-0451-4000-b000-000000000000"
#define UUID_HUM_DATA @"f000aa21-0451-4000-b000-000000000000"
#define UUID_HUM_CONF @"f000aa22-0451-4000-b000-000000000000"     // 0: disable, 1: enable
#define UUID_HUM_PERI @"f000aa23-0451-4000-b000-000000000000"
#define UUID_MOV_DATA @"F000AA81-0451-4000-b000-000000000000"
#define UUID_MOV_CONF @"F000AA82-0451-4000-b000-000000000000"
#define UUID_MOV_PERI @"F000AA83-0451-4000-b000-000000000000"
#define SENSORTAG_SERVICE_UUID @"AA80"
@synthesize delegate,nDevices,sensorTags,sensorTagPeripheral;
+(id)sharedCustomSensor{
    
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        
        _sharedObject = [[self alloc] init];
        
    });
    
    return _sharedObject;

}

-(void)counterUpload:(BOOL)connect UUID:(NSString *)UNIQUEID presetshutter:(NSString *)psss on:(BOOL)onnn
{
    r=0;
    globalcounttp=0;
    offf=onnn;
    arrCHARCTERCITS= [[NSMutableDictionary alloc]init];
    self.writeCommandArr=[[NSMutableArray alloc]initWithObjects:@"0901",@"0200",@"0900",@"04",@"03",@"0801",@"0800", nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SystmCommandWrite:) name:@"SYSTEMCommand" object:nil];
   
    greenindexxx=0;
    self.isUP=NO;
    self.isDown=NO;
    self.instrummetList=[[NSMutableArray alloc]init];
    self.response_Arr=[[NSMutableArray alloc]init];
    
    IOServiceUUID    = [CBUUID UUIDWithString:@"F000AA64-0451-4000-B000-000000000000"];
    IODataUUID       = [CBUUID UUIDWithString:@"F000AA65-0451-4000-B000-000000000000"];
    IOConfigUUID     = [CBUUID UUIDWithString:@"F000AA66-0451-4000-B000-000000000000"];
    self.m = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.nDevices = [[NSMutableArray alloc]init];
    self.sensorTags = [[NSMutableArray alloc]init];
    self.m.delegate = self;

    myPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    _data = [[NSMutableData alloc] init];

    readDevice=psss;
}

-(void)connect:(BOOL)connect UUID:(NSString *)UNIQUEID presetshutter:(NSString *)psss on:(BOOL)onnn {
    r=0;
    for(CBPeripheral *p  in self.sensorTags) {
        p.delegate=self;
        NSUUID* serverId = [p identifier];
        if (onnn && [serverId.UUIDString isEqualToString:UNIQUEID]) {
            [self.m connectPeripheral:p options:nil];
        } else {
            [self.m cancelPeripheralConnection:p];
        }
        NSLog(@"serverId MAC ADDRESS %@",serverId.UUIDString);
        [self.instrummetList addObject:p.identifier.UUIDString];
    }
}

-(void)readPreset:(BOOL)connect UUID:(NSString *)UNIQUEID presetshutter:(NSString *)psss on:(BOOL)onnn
{
    r=0;
    prestcount=1;
    self.readPresetArr=[[NSMutableArray alloc]init];
    globalcounttp=0;
    offf=onnn;
    arrCHARCTERCITS= [[NSMutableDictionary alloc]init];
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(StagNames)
    //                                                 name:@"stopscanning"
    //                                               object:nil];
    
    self.writeCommandArr=[[NSMutableArray alloc]initWithObjects:@"0901",@"0200",@"0900",@"04",@"0801",@"0800",nil];
    
    
    
    greenindexxx=0;
    self.isUP=NO;
    self.isDown=NO;
    self.instrummetList=[[NSMutableArray alloc]init];
    self.response_Arr=[[NSMutableArray alloc]init];
    //    IRTemperatureServiceUUID= [CBUUID UUIDWithString:@"F000AA00-0451-4000-B000-000000000000"];
    //    IRTemperatureDataUUID       = [CBUUID UUIDWithString:@"F000AA01-0451-4000-B000-000000000000"];
    //    IRTemperatureConfigUUID     = [CBUUID UUIDWithString:@"F000AA02-0451-4000-B000-000000000000"];
    
    IOServiceUUID    = [CBUUID UUIDWithString:@"F000AA64-0451-4000-B000-000000000000"];
    IODataUUID       = [CBUUID UUIDWithString:@"F000AA65-0451-4000-B000-000000000000"];
    IOConfigUUID     = [CBUUID UUIDWithString:@"F000AA66-0451-4000-B000-000000000000"];
    self.m = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.nDevices = [[NSMutableArray alloc]init];
    self.sensorTags = [[NSMutableArray alloc]init];
    self.m.delegate = self;
    
    ////
    myPeripheralManager =
    [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    _data = [[NSMutableData alloc] init];
    
    //[myPeripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:@"F000AA00-0451-4000-B000-000000000000"]] }];
    
    r=0;
    readDevice=psss;
  [self performSelector:@selector(readPreset) withObject:self afterDelay:3.0];
    // [self readPreset];
}
-(void)clock
{
   
   // self.readPresetArr=[[NSMutableArray alloc]init];
    globalcounttp=0;
    
    arrCHARCTERCITS= [[NSMutableDictionary alloc]init];
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(StagNames)
    //                                                 name:@"stopscanning"
    //                                               object:nil];
    
    self.writeCommandArr=[[NSMutableArray alloc]initWithObjects:@"0901",@"0200",@"0900",@"04",@"0801",@"0800", nil];
   
    
    
    greenindexxx=0;
   // self.isUP=NO;
   // self.isDown=NO;
    self.instrummetList=[[NSMutableArray alloc]init];
    self.response_Arr=[[NSMutableArray alloc]init];
    //    IRTemperatureServiceUUID= [CBUUID UUIDWithString:@"F000AA00-0451-4000-B000-000000000000"];
    //    IRTemperatureDataUUID       = [CBUUID UUIDWithString:@"F000AA01-0451-4000-B000-000000000000"];
    //    IRTemperatureConfigUUID     = [CBUUID UUIDWithString:@"F000AA02-0451-4000-B000-000000000000"];
    
    IOServiceUUID    = [CBUUID UUIDWithString:@"F000AA64-0451-4000-B000-000000000000"];
    IODataUUID       = [CBUUID UUIDWithString:@"F000AA65-0451-4000-B000-000000000000"];
    IOConfigUUID     = [CBUUID UUIDWithString:@"F000AA66-0451-4000-B000-000000000000"];
    self.m = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.nDevices = [[NSMutableArray alloc]init];
    self.sensorTags = [[NSMutableArray alloc]init];
    self.m.delegate = self;
    
    ////
//    myPeripheralManager =
//    [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
//    
//    _data = [[NSMutableData alloc] init];
//    
    //[myPeripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:@"F000AA00-0451-4000-B000-000000000000"]] }];
    
    
    r=0;
 // [self performSelector:@selector(connectClockID) withObject:self afterDelay:5.0];
   // [self readPreset];
}

-(void)SystmCommandWrite:(NSNotification *)notify {
    NSDictionary *dict=notify.userInfo;
    NSLog(@"notify %@",notify.userInfo);
    for(CBPeripheral *p  in self.sensorTags) {
        NSUUID* serverId = [p identifier];
        if([[dict valueForKey:@"uuid"] isEqualToString:serverId.UUIDString]) {
            [self.m connectPeripheral:p options:nil];
            p.delegate=self;
            greenindexxx=0;
            [self performSelector:@selector(callSytemID:) withObject:dict afterDelay:5.0f];
            [[NSNotificationCenter defaultCenter] removeObserver:self];

            break;
       
            }
        }
    }
-(int)scanValue:(NSString *)valll
{
    
    NSScanner* pScanner = [NSScanner scannerWithString: valll];
    unsigned int dayValue;
    [pScanner scanHexInt: &dayValue];
    
    return dayValue;

}
-(void)PRESETINFO:(CBPeripheral *)perpral
{
    
    greenindexxx=0;
    ttt=[NSTimer scheduledTimerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(getPresetData:)
                                       userInfo:perpral
                                        repeats:YES];

}
-(void)caliberatePreset
{
    NSLog(@"THE READ PRESET ARRAY IS %@",self.readPresetArr);
    NSMutableArray *items=[[NSMutableArray alloc]init];
    NSMutableArray *presetarr=[[NSMutableArray alloc]init];

    NSMutableArray *peripherlarr=[[NSMutableArray alloc]init];


    for (int i=0; i<self.readPresetArr.count; i++) {
       
        NSString *str=[self.readPresetArr objectAtIndex:i];
        items= (NSMutableArray *)[str componentsSeparatedByString:@"="];
        for (int j=0; j<items.count; j++) {
            if (j%2==0) {
                
                [presetarr addObject:[items objectAtIndex:j]];
                
            }
            else
            {
                
                [peripherlarr addObject:[items objectAtIndex:j]];
                
                
            }
  
        }
    }
    
    
    
    NSLog(@"presetarr RRAY IS %@",presetarr);
    NSLog(@"peripherlarr IS %@",peripherlarr);
    int j=0;
    NSMutableArray *DATA=[[NSMutableArray alloc]init];
    NSMutableArray *presetINFO=[[NSMutableArray alloc]init];
    
      for (int i=0; i<presetarr.count; i++) {
          j=0;
          
        
        NSString * hexStr = [NSString stringWithFormat:@"%@",[presetarr objectAtIndex:i]];
          
          if (DATA) {
              [DATA removeAllObjects];
              
          }
          

        
        
        //for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">",@" ",nil])
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@">" withString:@""];
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@" " withString:@""];
          
            
            
            
          
            

        
          [presetINFO addObject:hexStr];
          //[presetINFO insertObject:<#(nonnull id)#> atIndex:<#(NSUInteger)#>];
      
      
      }
    
    NSLog(@"DATAIS %@",presetINFO);

   [self extractPreset:presetINFO peripheral:peripherlarr];


}

-(void)extractPreset:(NSMutableArray *)preset peripheral:(NSMutableArray *)prphral
{
    self.calibertaedPresetArr=[[NSMutableArray alloc]init];
    
    for(int i=0;i<preset.count; i++) {
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSString *strrr=[preset objectAtIndex:i];
        
        for (int kk=0; kk<strrr.length-1; kk=kk+2) {
            NSString *bits=[strrr substringWithRange:NSMakeRange(kk, 2)];
            [arr addObject:bits];
        }
        
        
        NSLog(@"bits arrrr %@",arr);
        Preset *preset_obj=[[Preset alloc]init];
        preset_obj.serial_number=[arr objectAtIndex:1];
        preset_obj.mottor=[arr objectAtIndex:2];
        preset_obj.days=[arr objectAtIndex:3];
        int hex_hrr=[self scanValue:[arr objectAtIndex:4]];
        preset_obj.hour=[NSString stringWithFormat:@"%d",hex_hrr];
        int hex_min =[self scanValue:[arr objectAtIndex:5]];
        preset_obj.min=[NSString stringWithFormat:@"%d",hex_min];
        preset_obj.uuid_device=[prphral objectAtIndex:i];
        NSString *namee= [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@",[arr objectAtIndex:6],[arr objectAtIndex:7],[arr objectAtIndex:8],[arr objectAtIndex:9],[arr objectAtIndex:10],[arr objectAtIndex:11],[arr objectAtIndex:12],[arr objectAtIndex:13],[arr objectAtIndex:14],[arr objectAtIndex:15],[arr objectAtIndex:16],[arr objectAtIndex:17]];
        NSString *nameHex=[self stringFromHexString:namee];
        preset_obj.name=nameHex;
        
        
        NSLog(@"preset nameHexnameHex %@",nameHex);
        [arr removeAllObjects];
        [self.calibertaedPresetArr addObject:preset_obj];
    }
    
    
    [self categorisePreset:self.calibertaedPresetArr];
    
  //  NSLog(@"self.calibertaedPresetArr %@",[[self.calibertaedPresetArr objectAtIndex:0] serial_number]);
    
    

}
-(void)categorisePreset:(NSMutableArray*)arrrr
{
   NSMutableArray *preseTableCatgry=[[NSMutableArray alloc]init];
    for (int i=0; i<arrrr.count; i++) {
        
        Preset *pres=(Preset *)[arrrr objectAtIndex:i];
        NSLog(@"preset name %@",pres.name);
          NSMutableArray *preseTMatch=[[NSMutableArray alloc]init];
        for (int jj=0;jj<arrrr.count; jj++){
            
            Preset *prest_sec=(Preset *)[arrrr objectAtIndex:jj];
            if ([pres.name isEqualToString:prest_sec.name]) {
              
                     [preseTMatch addObject:prest_sec];
                
               
            
            }
            
            
            
        }
        
        if (![preseTableCatgry containsObject:preseTMatch]) {
              [preseTableCatgry addObject:preseTMatch];
        }
    
       
        
        
    }
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:preseTableCatgry];
    [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"saved_presets"];
    
    [[NSUserDefaults standardUserDefaults] synchronize]; // this will save you UserDefaults
   
    if([self.delegate respondsToSelector:@selector(loadPresets:)])
    {
        
        [self.delegate loadPresets:preseTableCatgry];
        
        
    }

    NSLog(@"preseTableCatgry %@",preseTableCatgry);
}
-(void)readPreset
{
    
    if(IOCharacteristic != nil){
        
        [ttt invalidate];
        if (offf==YES){
            
        if(IOCharacteristic != nil){
            
            offf=NO;
            
            // for(int i=0;i<self.sensorTags.count;i++) {
            if (r<self.sensorTags.count) {
                   
                    CBPeripheral *p=[self.sensorTags objectAtIndex:r];
                     [self performSelector:@selector(PRESETINFO:) withObject:p afterDelay:3.0];
                    
                 
                    
                    
                }
                else{
                    
                    
                    [self caliberatePreset];
                    
                    NSLog(@"THE READ PRESET ARRAY IS %@",self.readPresetArr);
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"readPresetEND"
                     object:self userInfo:nil];
                
                
                }
            }
            
            
        }
        
    }
    
}

- (void)connnectAndDiscoverServices:(CBPeripheral *)p {
    self.discoverServicesAfterConnect = true;
    [self.m connectPeripheral:p options:nil];
}

-(void)counterUploadshuttr:(BOOL)connect UUID:(NSString *)UNIQUEID presetshutter:(NSString *)psss on:(BOOL)onnn {
    if ([psss isEqualToString:@"shutterMotor"]) {
        for(CBPeripheral *p  in self.sensorTags) {
            p.delegate=self;
            [self connnectAndDiscoverServices:p];
            NSUUID* serverId = [p identifier];
            if ([UNIQUEID isEqualToString:serverId.UUIDString]) {
                [self readMotor:p];
            }
        }
    } else if ([psss isEqualToString:@"NewPresetMotor"]) {
        for(CBPeripheral *p  in self.sensorTags) {
            NSUUID* serverId = [p identifier];
            if ([UNIQUEID isEqualToString:serverId.UUIDString]) {
                p.delegate=self;
                [self connnectAndDiscoverServices:p];
            }
        }
    }
}


-(void)MotorReadDate:(CBPeripheral*)UNIQUEID
{
    ttt=[NSTimer scheduledTimerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(getMesageForMOTOR:)
                                       userInfo:UNIQUEID
                                        repeats:YES];
    
    
}
-(void)readMotor:(CBPeripheral*)UNIQUEID
{
    if (IOCharacteristic != nil){
        [ttt invalidate];
        [self.m connectPeripheral:UNIQUEID options:nil];
        [self performSelector:@selector(MotorReadDate:) withObject:UNIQUEID afterDelay:5.0f];
        
        
    }
}
-(void)getMesageForMOTOR:(NSTimer*)theTimer
{
    CBPeripheral *P=[theTimer userInfo];
    IOCharacteristic=(CBCharacteristic *)[arrCHARCTERCITS objectForKey:P];
    if(greenindexxx<4)
    {
        NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe],[NSNumber numberWithInt:0x02],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0xff],nil];
        int valueToWrite = [[arr objectAtIndex:greenindexxx]intValue];
        char* bytes = (char*) &valueToWrite;
        NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
        [P writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
        greenindexxx++;
    }
    else
    {
        [ttt invalidate];
        offf=YES;
        greenindexxx=0;
    }
}
-(void)getPresetData:(NSTimer*)theTimer
{
    
    CBPeripheral *p=[theTimer userInfo];
    IOCharacteristic=(CBCharacteristic *)[arrCHARCTERCITS objectForKey:p];
   
    
    if(greenindexxx<4){
      
            
        
        NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe],[NSNumber numberWithInt:0x04],[NSNumber numberWithInt:prestcount],[NSNumber numberWithInt:0xff],nil];
        int valueToWrite = [[arr objectAtIndex:greenindexxx]intValue];
        char* bytes = (char*) &valueToWrite;
        NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
        [p writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
        greenindexxx++;
       
    }
    
    else{
        
        /////04010105 0f0f4d4f 47000000 00000000 0000>
//        [ttt invalidate];
//        ttt=nil;
//        greenindexxx=0;
//        offf=YES;
        //prestcount=0;
       //
        
        
    }
}
-(void)sendPresets:(NSDictionary *)dicttnry newPreset:(NSString *)newpreset;
{
    
    if(IOCharacteristic != nil){
        
        [ttt invalidate];
        for(CBPeripheral *p  in self.sensorTags) {
            NSUUID* serverId = [p identifier];
            
            if([[dicttnry valueForKey:@"UUID"] isEqualToString:serverId.UUIDString]) {
                [dicttnry setValue:p forKey:@"periphral"];
                [self.m connectPeripheral:p options:nil];
                p.delegate=self;
                greenindexxx=0;
                [self performSelector:@selector(presetWritte:) withObject:dicttnry afterDelay:5.0f];
               // [[NSNotificationCenter defaultCenter] removeObserver:self];
                
                break;
                
            }
        }

        
        
    }
    
}
-(void)presetWritte:(NSDictionary*)dict
{
    
    ttt=[NSTimer scheduledTimerWithTimeInterval:0.01
                                          target:self
                                        selector:@selector(writePreset:)
                                        userInfo:dict
                                         repeats:YES];
}

-(void)writePreset:(NSTimer*)theTimer
{
    
    
    
        NSDictionary *dict=[theTimer userInfo];
        NSString * name=[dict valueForKey:@"name"];
        int motor=[[dict valueForKey:@"motor"]intValue];
        int hour=[[dict valueForKey:@"hour"]intValue];
        int min=[[dict valueForKey:@"min"]intValue];
        int days=[[dict valueForKey:@"days"]intValue];
        int serialNum=[[dict valueForKey:@"serialnum"]intValue];
        CBPeripheral *pp=(CBPeripheral *)[dict valueForKey:@"periphral"];
        // long indxx=[self.sensorTags indexOfObject:p];
        IOCharacteristic=(CBCharacteristic *)[arrCHARCTERCITS objectForKey:pp];
        NSString *checkStr=[self gethex:name];
        // NSString*checkStr=[theTimer userInfo];
        NSUInteger length = [checkStr length]/2;
        NSInteger lengthcount= length +8;
        NSLog(@"lengthcount%ld",(long)lengthcount);
        BOOL collision=NO;
        if ([checkStr length]>24)
        {
            
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                                             message:@"You have reached maximum limit!"
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles: nil];
            
            
            [alert show];
            
        }
        else
            
        {
            
            
            if(greenindexxx<lengthcount)
                
            {
              
                NSMutableArray *array = [[NSMutableArray array]init];
                NSString * str = checkStr;
                NSMutableString * newString = [[NSMutableString alloc] init] ;
                int i = 0;
                while (i < [str length])
                {
                    NSString * hexChar = [str substringWithRange: NSMakeRange(i, 2)];
                    int value = 0;
                    sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x",&value);
                    [newString appendFormat:@"%c", (char)value];
                    NSString *hexxxx=[NSString stringWithFormat:@"0x%@",hexChar];
                    int ddd=[self scanValue:hexxxx];
                    [array addObject:[NSNumber numberWithInt:ddd]];
                    i+=2;
                    NSLog(@"Output%@",array);
                    
                }
        
        NSArray*newArray=[[NSArray alloc]init];
        NSMutableArray *arr;
        
            if ([[dict valueForKey:@"NEWPREST"] isEqualToString:@"oldpreset"]) {
                    
                    arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe] , [NSNumber numberWithInt:0x03], [NSNumber numberWithInt:serialNum],[NSNumber numberWithInt:motor] , [NSNumber numberWithInt:days],[NSNumber numberWithInt:hour],[NSNumber numberWithInt:min],nil];
    
                }
                else{
                   
                    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved_presets"];
                    // if (data.length<1) {
               //   NSMutableArray *  PrestArr= [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:data error:nil];
                     NSMutableArray *preseTMatch=[[NSMutableArray alloc]init];
                    for (int i=0; i<self.calibertaedPresetArr.count; i++) {
                        
                        Preset *pres=(Preset *)[self.calibertaedPresetArr objectAtIndex:i];
                       // NSLog(@"preset name %@",pres.name);
                        if ([[dict valueForKey:@"UUID"] isEqualToString:pres.uuid_device]) {
                            [preseTMatch addObject:pres];
                        }
                        if ([pres.name  isEqualToString:name]) {
                            collision=YES;
                        }
                        
                        
                    }
                    
                            
                            
                    
                        
                    if (collision==YES) {
                        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                                                         message:@"Preset with the name already exists!"
                                                                        delegate:self
                                                               cancelButtonTitle:@"ok"
                                                               otherButtonTitles: nil];
                        
                        
                        [alert show];
                        

                    }
                    else{
                    int serialNO=(int)preseTMatch.count +1;
                    
                    arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe] , [NSNumber numberWithInt:03], [NSNumber numberWithInt:serialNO],[NSNumber numberWithInt:motor] , [NSNumber numberWithInt:days],[NSNumber numberWithInt:hour],[NSNumber numberWithInt:min],nil];
                    }
                }
                
        NSMutableArray *arr1=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xff],nil];
        NSArray*Aaaa =[arr arrayByAddingObjectsFromArray:array];
        newArray =[Aaaa arrayByAddingObjectsFromArray:arr1];
        int valueToWrite = [[newArray objectAtIndex:greenindexxx]intValue];
        char* bytes = (char*) &valueToWrite;
        //char* bytes = (char*)&valueToWrite;
        NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
        [pp writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
        greenindexxx++;
          
            }
        
        
    
    else{
        
        /////04010105 0f0f4d4f 47000000 00000000 0000>
        
        [ttt invalidate];
        offf=YES;
        greenindexxx=0;
        
        
    }
        
        }
    
}
-(void)clockread:(CBPeripheral*)peripheral
{
    
    
}

-(void)connectClockID
{
    
        if (IOCharacteristic != nil){
            
            clockUpadte=true;
            if (r<self.sensorTags.count) {
                
                CBPeripheral *p=[self.sensorTags objectAtIndex:r];
                
               // [self.m connectPeripheral:p options:nil];
               // p.delegate=self;
                //greenindexxx=0;
                ttt=[NSTimer scheduledTimerWithTimeInterval:0.01
                     
                                                     target:self
                                                   selector:@selector(clocIdCommand:)
                                                   userInfo:p
                                                    repeats:YES];


                

                           }
            else
            {
            
                NSLog(@"the rrrr is fulll");
            }
            
        }
        
    
}




-(void)clocIdCommand:(NSTimer*)theTimer
{
    CBPeripheral *p=[theTimer userInfo];
    IOCharacteristic=(CBCharacteristic *)[arrCHARCTERCITS objectForKey:p];
    

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit| NSSecondCalendarUnit fromDate:[NSDate date]];
    NSString *sttr=[[NSString stringWithFormat:@"%ld",[components year]] substringFromIndex:2];
   
    // NSString *yrr=[sttr substringFromIndex:2];
   // NSString*  command= [self gethexfrmDec:[NSString stringWithFormat:@"%ld",(long)0x0a]];
      NSString*  day = [self gethexfrmDec:[NSString stringWithFormat:@"%ld",(long)[components day]]];
    NSString* month = [self gethexfrmDec:[NSString stringWithFormat:@"%ld",(long)[components month]]];
    NSString* year = [self gethexfrmDec:[NSString stringWithFormat:@"%@",sttr]];
    NSString * hrr = [self gethexfrmDec:[NSString stringWithFormat:@"%ld",(long)[components hour]]];
    NSString * min = [self gethexfrmDec:[NSString stringWithFormat:@"%ld",(long)[components minute]]];
    NSString * secc =[self gethexfrmDec:[NSString stringWithFormat:@"%ld",(long)[components second]]];
   
    //NSString *string = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)day, (long)month, (long)year];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm:ss"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *theDate = [dateFormat stringFromDate:now];
    NSString *dateString = [format stringFromDate:now];
    NSString *theTime = [timeFormat stringFromDate:now];
    
    NSString *weeks = [dateFormatter stringFromDate:now];
//    NSLog(@"\n"
//          "theDate: |%@| \n"
//          "theTime: |%@| \n"
//          "Now: |%@| \n"
//          "Week: |%@| \n"
//          , theDate, theTime,dateString,weeks);
    NSString *  weekday =[self gethexfrmDec
                          :[NSString stringWithFormat:@"%@",weeks]];
    
    if(greenindexxx<20){
       
        //int commm=[self scanValue:@"0x0A"];
        int dayValue=[self scanValue:day];
        int monthValue=[self scanValue:month];
        int yearValue=[self scanValue:year];
        int hrrValue=[self scanValue:hrr];
        int minValue=[self scanValue:min];
        int seccValue=[self scanValue:secc];
        //NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe],[NSNumber numberWithInt:0x01],[NSNumber numberWithInt:0x01],[NSNumber numberWithInt:2],[NSNumber numberWithInt:0xff],nil];
        NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe],[NSNumber numberWithInt:0x08],[NSNumber numberWithInt:0x01],[NSNumber numberWithInt:dayValue],[NSNumber numberWithInt:monthValue],[NSNumber numberWithInt:yearValue],[NSNumber numberWithInt:seccValue],[NSNumber numberWithInt:hrrValue],[NSNumber numberWithInt:minValue],[NSNumber numberWithInt:0xff],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0xff],nil];
        
        int valueToWrite = [[arr objectAtIndex:greenindexxx]intValue];
        char* bytes = (char*) &valueToWrite;
        NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
        [p writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
        greenindexxx++;
     ////get it done to always
        
    }
    else{
        
        /////04010105 0f0f4d4f 47000000 00000000 0000>
        
        [ttt invalidate];
        ttt=nil;
        greenindexxx=0;
       
        
        NSInteger rr= [self.sensorTags count];
        if (r<rr) {
            r++;
            [self connectClockID];
        }
        
        
    }

}

-(void)connectCommand
{
    if (offf==YES){
        if (IOCharacteristic != nil) {
            offf=NO;
            if (r<self.sensorTags.count) {
                //CBPeripheral *p=[self.sensorTags objectAtIndex:r];
                //ReadTime=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(readSytemID:) userInfo:p repeats:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tableAftrRead" object:self userInfo:nil];            }
        }
    }
}

-(void)readSytemID:(NSTimer*)theTimer {
    CBPeripheral *p=[theTimer userInfo];
    IOCharacteristic=(CBCharacteristic *)[arrCHARCTERCITS objectForKey:p];
    if(greenindexxx<4) {
        NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe],[NSNumber numberWithInt:0x09],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0xff],nil];
        int valueToWrite = [[arr objectAtIndex:greenindexxx]intValue];
        char* bytes = (char*) &valueToWrite;
        NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
        [p writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
        greenindexxx++;
    } else {
        [ReadTime invalidate];
        ReadTime=nil;
        greenindexxx=0;
        offf=YES;
        NSInteger rr= [self.sensorTags count];
        if (r<rr) {
            r++;
            [self connectCommand];
        }
    }
}

-(void)callSytemID:(NSDictionary*)dict {
    ttt1=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(callSytemIDddd:) userInfo:dict repeats:YES];
}

-(void)callSytemIDddd:(NSTimer*)theTimer
{
    
    NSDictionary *dic=[theTimer userInfo];
    //[dic enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSString *object, BOOL *stop) {
        
    for(CBPeripheral *p  in self.sensorTags) {
        
        
            //p.delegate=self;
            NSUUID* serverId = [p identifier];
        
            if ([[dic valueForKey:@"uuid"] isEqualToString:serverId.UUIDString]) {
                
               // long indxx=[self.sensorTags indexOfObject:p];
               IOCharacteristic=(CBCharacteristic *)[arrCHARCTERCITS objectForKey:p];
                NSString *vall=[dic valueForKey:serverId.UUIDString];
                NSString *checkStr=[self gethex:vall];
               // NSString*checkStr=[theTimer userInfo];
                NSUInteger length = [checkStr length]/2;
                NSInteger lengthcount= length +4;
                NSLog(@"lengthcount%ld",(long)lengthcount);
                
                if ([checkStr length]>32)
                {
                    
                    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Open Shutter"
                                                                     message:@"You have reached maximum limit!"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles: nil];
                    
                    
                    [alert show];
                    
                }
                else
                    
                {
                    
                
                if(greenindexxx<lengthcount)
                
                {
                    NSMutableArray *array = [[NSMutableArray array]init];
                    NSString * str = checkStr;
                    NSMutableString * newString = [[NSMutableString alloc] init] ;
                    int i = 0;
                    while (i < [str length])
                    {
                        NSString * hexChar = [str substringWithRange: NSMakeRange(i, 2)];
                        int value = 0;
                        sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x",&value);
                        [newString appendFormat:@"%c", (char)value];
                        NSString *hexxxx=[NSString stringWithFormat:@"0x%@",hexChar];
                        int ddd=[self scanValue:hexxxx];
                        [array addObject:[NSNumber numberWithInt:ddd]];
                        i+=2;
                        NSLog(@"Output%@",array);
                        
                    }
                    
                    NSArray*newArray=[[NSArray alloc]init];
                    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe] , [NSNumber numberWithInt:0x09], [NSNumber numberWithInt:0x01], nil];
                    NSMutableArray *arr1=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xff],nil];
                    NSArray*Aaaa =[arr arrayByAddingObjectsFromArray:array];
                    newArray =[Aaaa arrayByAddingObjectsFromArray:arr1];
                    int valueToWrite = [[newArray objectAtIndex:greenindexxx]intValue];
                    char* bytes = (char*) &valueToWrite;
                    //char* bytes = (char*)&valueToWrite;
                    NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
                    [p writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
                    greenindexxx++;
                    
                    
                }
                
                else
                    
                {
                    
                    [ttt1 invalidate];
                    ttt1=nil;
                    greenindexxx=0;
                    
                    
                }
               
            }
                
                
        }
            
    }

    
}


-(void)lightGreenOff
{
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"SaveCBPeripheral"];
    
    for(CBPeripheral *p  in self.sensorTags)
    {
        NSUUID* serverId = [p identifier];
        
        if ([savedValue isEqualToString:serverId.UUIDString])
        {
            [self.m cancelPeripheralConnection:p];
        }
        if (IOCharacteristic != nil)
        {
            
        } }
}

-(void)readMotor
{
    if (IOCharacteristic != nil){
        
        self.isUP=NO;
        self.isDown=NO;
        //        int bladeindxx=[blade intValue];
        int valueToWrite = 2;
        char* bytes = (char*) &valueToWrite;
        // [self gethex];
        [ttt invalidate];
        
        ttt=[NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(getMesageForMOTOR:)
                                           userInfo:nil
                                            repeats:YES];
        
    }
    
    
}

//-(void)getMesageForMOTOR:(NSTimer*)theTimer
//{
//    if(greenindexxx<20){
//        
//        //int bladdee=[[theTimer userInfo]intValue];
//        
//        //         NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe],[NSNumber numberWithInt:0x09],[NSNumber numberWithInt:0x01],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0xff],nil];
//        NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe],[NSNumber numberWithInt:0x02],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0x00],[NSNumber numberWithInt:0xff],nil];
//        
//        int valueToWrite = [[arr objectAtIndex:greenindexxx]intValue];
//        char* bytes = (char*) &valueToWrite;
//        NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
//        [self.sensorTagPeripheral writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
//        greenindexxx++;
//        
//        }
//
//    else{
//        
//        /////04010105 0f0f4d4f 47000000 00000000 0000>
//        
//        [ttt invalidate];
//        offf=YES;
//        greenindexxx=0;
//       
//        
//        
//    }
//}

-(void)writeMOtor:(NSTimer*)theTimer
{
    
    CBPeripheral *p=[theTimer userInfo];
    IOCharacteristic=(CBCharacteristic *)[arrCHARCTERCITS objectForKey:p];
    if(greenindexxx<5){
        
        int  BladeValue  = [[[NSUserDefaults standardUserDefaults]
                             stringForKey:@"BladePosition"]intValue];
        int bladdee=BladeValue -1;
        
        NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0xfe],[NSNumber numberWithInt:0x01],[NSNumber numberWithInt:0x01],[NSNumber numberWithInt:bladdee],[NSNumber numberWithInt:0xff],nil];
        
        int valueToWrite = [[arr objectAtIndex:greenindexxx]intValue];
        char* bytes = (char*) &valueToWrite;
        NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
        [p writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
        greenindexxx++;
    }
    else
    {
        [ttt invalidate];
        greenindexxx=0;
    }
}
-(void)lightGreenOn:(NSString *)blade
{
    if (IOCharacteristic != nil){
        self.isUP=NO;
        self.isDown=NO;
        int valueToWrite = 2;
        char* bytes = (char*) &valueToWrite;
        // [self gethex];
        [ttt invalidate];
        [[NSUserDefaults standardUserDefaults] setObject:blade forKey:@"BladePosition"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"SaveCBPeripheral"];
        for(CBPeripheral *p  in self.sensorTags)
        {
            NSUUID* serverId = [p identifier];
            
            if ([savedValue isEqualToString:serverId.UUIDString]) {
                
                //[self readMotor:p];
                
                
                ttt=[NSTimer scheduledTimerWithTimeInterval:0.01
                                                     target:self
                                                   selector:@selector(writeMOtor:)
                                                   userInfo:p
                                                    repeats:YES];
                
            }
            
        }
        
    }
    // }
}
-(void)lightRedOff
{
    if (IOCharacteristic != nil){
        
        int valueToWrite = 0;
        
        // self.isUP=YES;
        // self.isDown=YES;
        
        char* bytes = (char*) &valueToWrite;
        NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
        //  id writeValueIO = NSData(bytes: &valueToWrite, length: sizeof(UInt8))
        // self.sensorTagPeripheral.writeValue(writeValueIO, forCharacteristic: IOCharacteristic, type: CBCharacteristicWriteType.WithResponse)
        [self.sensorTagPeripheral writeValue:writeValueIO forCharacteristic:IOCharacteristic type:CBCharacteristicWriteWithResponse];
        NSLog(@"bytes %s",bytes);
        NSLog(@"writeValueIO %@",writeValueIO);
        }
}
-(void)lightRedOn:(NSString *)blade
{
    if (IOCharacteristic != nil){
        
        
    }
}
-(NSString *)gethexfrmDec:(NSString *)strrr
{
    // NSString *dec = @"254";
     NSString *hex = [NSString stringWithFormat:@"0x%lX",
                     (unsigned long)[strrr integerValue]];
     NSLog(@"%@", hex);
     // NSLog(@"gethex%@", hexStr);
     return hex;
    
}
- (NSString *)stringFromHexString:(NSString *)hexString {
    
    // The hex codes should all be two characters.
    if (([hexString length] % 2) != 0)
        return nil;
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSInteger i = 0; i < [hexString length]; i += 2) {
        
        NSString *hex = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSInteger decimalValue = 0;
        sscanf([hex UTF8String], "%x", &decimalValue);
        [string appendFormat:@"%c", decimalValue];
    }
    
    return string;
}

-(NSString *)gethex:(NSString *)strrr
{
    NSString * str = strrr;
    
    NSString * hexStr =[NSString stringWithFormat:@"%@",
                         [NSData dataWithBytes:[str cStringUsingEncoding:NSUTF8StringEncoding]
                                        length:strlen([str cStringUsingEncoding:NSUTF8StringEncoding])]];
    
    for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", @" ", nil])
        hexStr = [hexStr stringByReplacingOccurrencesOfString:toRemove withString:@""];
    
    NSLog(@"gethex%@", hexStr);
    return hexStr;

}

-(void)getMotionData:(NSData *)data
{
    //http://processors.wiki.ti.com/index.php/CC2650_SensorTag_User's_Guide#Movement_Sensor
   //unsigned char *orgBytes = (unsigned char *)[data bytes];
    //char* bytes = (char*) &valueToWrite;
    NSUInteger len = [data length];
    Byte *orgBytes = (Byte*)malloc(len);
    NSString * str = @"MORNING";
    
    NSString * hexStr = [NSString stringWithFormat:@"%@",
                         [NSData dataWithBytes:orgBytes
                                        length:sizeof(18)]];
    
    for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", @" ", nil])
        hexStr = [hexStr stringByReplacingOccurrencesOfString:toRemove withString:@""];
    
    NSLog(@"%@", hexStr);
    NSLog(@"orgBytes%ld", orgBytes);
    
    int16_t gyroX = (orgBytes[1]  << 8) + orgBytes[0];
    int16_t gyroY = (orgBytes[3]  << 8) + orgBytes[2];
    int16_t gyroZ = (orgBytes[5] << 8) + orgBytes[4];
    int16_t accX  = (orgBytes[7] << 8) + orgBytes[6];
    int16_t accY  = (orgBytes[9] << 8) + orgBytes[8];
    int16_t accZ  = (orgBytes[11] << 8) + orgBytes[10];
    int16_t magX  = (orgBytes[13] << 8) + orgBytes[12];
    int16_t magY  = (orgBytes[15] << 8) + orgBytes[14];
    int16_t magZ  = (orgBytes[17] << 8) + orgBytes[16];
//
    //NSLog(@"%f %f %f", sensorMpu9250GyroConvert(gyroX),sensorMpu9250GyroConvert(gyroY),sensorMpu9250GyroConvert(gyroZ));
    //    NSLog(@"%f %f %f", sensorMpu9250AccConvert(accX, accRange),sensorMpu9250AccConvert(accY, accRange),sensorMpu9250AccConvert(accZ, accRange));
    //    NSLog(@"%f %f %f", sensorMpu9250MagConvert(magX),sensorMpu9250MagConvert(magY),sensorMpu9250MagConvert(magZ));
    
    // -- Label --
    
}
#pragma mark - SENSOR TAG BLE DELEGATES
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_MOV_DATA]]) {
        NSLog(@"UUID_MOV_DATA updated value is %@  ///%@",peripheral,characteristic.value);
        NSString * hexStr = [NSString stringWithFormat:@"%@", characteristic.value];
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@">" withString:@""];
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *writeCommd=[hexStr substringToIndex:4];
        hexStr=[hexStr substringFromIndex:4];
       
        NSString *realstrr=[self
                           stringFromHexString:hexStr];
        NSLog(@"realstrr%@", realstrr);
        if ([writeCommd isEqualToString:@"0901"]) {
           if (![hexStr containsString:@"000000000000000000000000000000000000"] && [self.writeCommandArr containsObject:writeCommd]) {
               [self.m cancelPeripheralConnection:peripheral];
               NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
               NSLog(@"DevicesNamedList value is %@", [userDeafult  valueForKey:DevicesNamedList]);
               NSMutableDictionary *diccttt=[userDeafult  objectForKey:DevicesNamedList];
               for(id key in diccttt){
                   NSLog(@"key: %@, value: %@", key, [diccttt objectForKey:key]);
                   if ([key isEqualToString:peripheral.identifier.UUIDString]) {
                       if(diccttt.count>0) {
                           if (realstrr) {
                               NSMutableDictionary* dictionary_devices=[[[NSMutableDictionary alloc]init]mutableCopy];
                               dictionary_devices=[diccttt mutableCopy];
                               [dictionary_devices setValue:realstrr forKey:key];
                               [userDeafult  setObject:dictionary_devices forKey:DevicesNamedList];
                               [userDeafult synchronize];

                               [[NSNotificationCenter defaultCenter] postNotificationName:@"tableAftrWrite" object:self userInfo:nil];
                           } else {
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"tableAftrWrite" object:self userInfo:nil];
                           }
                       }
                   }
               }
           }
        } else  if([writeCommd isEqualToString:@"0900"]) {
            if (![hexStr containsString:@"000000000000000000000000000000000000"] && [self.writeCommandArr containsObject:writeCommd]) {
                [self.m cancelPeripheralConnection:peripheral];
                NSUserDefaults *defff=[NSUserDefaults standardUserDefaults];
                [self.response_Arr addObject:peripheral];
                NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
                NSLog(@"DevicesNamedList value is %@", [userDeafult  valueForKey:DevicesNamedList]);
                NSMutableDictionary *diccttt= [userDeafult  objectForKey:DevicesNamedList];
                NSLog(@"dicctttdiccttt %@", diccttt);
                for (id key in diccttt) {
                    NSLog(@"key: %@, value: %@", key, [diccttt objectForKey:key]);
                    if ([key isEqualToString:peripheral.identifier.UUIDString]) {
                        if (diccttt.count>0) {
                            if (realstrr!=nil && ![realstrr containsString:@"ABCDEFGHabcdef"]) {
                                NSMutableDictionary* dictionary_devices=[[[NSMutableDictionary alloc]init]mutableCopy];
                                dictionary_devices=[diccttt mutableCopy];
                                [dictionary_devices setValue:realstrr forKey:key];
                                [userDeafult  setObject:dictionary_devices forKey:DevicesNamedList];
                                [userDeafult synchronize];
                                NSLog(@"dictionary_devices %@", dictionary_devices);
                                if (self.response_Arr.count==self.sensorTags.count) {
                                    self.response_Arr=nil;
                                    r=0;
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"tableAftrRead" object:self userInfo:nil];
                                }
                            } else {
                                if (self.response_Arr.count==self.sensorTags.count) {
                                    self.response_Arr=nil;
                                    r=0;
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"tableAftrRead" object:self userInfo:nil];
                                }
                                NSMutableDictionary* dictionary_devices=[[[NSMutableDictionary alloc]init]mutableCopy];
                                dictionary_devices=[diccttt mutableCopy];
                                [dictionary_devices setValue:@"" forKey:key];
                                [userDeafult  setObject:dictionary_devices forKey:DevicesNamedList];
                                [userDeafult synchronize];
                                NSLog(@"dictionary_devices %@", dictionary_devices);
                            }
                        }
                    }
                }
            }
        } else  if([writeCommd containsString:@"0801"]) {
            if (![hexStr containsString:@"000000000000000000000000000000000000"] ) {
                [self.m cancelPeripheralConnection:peripheral];
                [self.response_Arr addObject:peripheral];
                NSLog(@"the self.respo && sensortag %@,,, %@",self.readPresetArr,self.sensorTags);
                self.response_Arr=nil;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"clockReadFinished" object:self userInfo:nil];
            }
        } else  if([writeCommd containsString:@"0800"]) {
            if (![hexStr containsString:@"000000000000000000000000000000000000"] ){
                [self.m cancelPeripheralConnection:peripheral];
                [self.response_Arr addObject:peripheral];
                NSLog(@"the self.respo && sensortag %@,,, %@",self.readPresetArr,self.sensorTags);
                self.response_Arr=nil;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"clockReadFinished" object:self userInfo:nil];
            }
        } else if ([writeCommd isEqualToString:@"0200"]) {
           NSString *motorValue=[hexStr substringToIndex:2];
           //hexStr=[motorValue substringFromIndex:2];
           int hex=[motorValue intValue];
           NSLog(@"motorrrrrr val is %d",hex);
           if (offf==YES) {
               if([self.delegate respondsToSelector:@selector(readMotorValue:)]) {
                   [self.delegate readMotorValue:hex];
               }
               offf=NO;
           }
        } else  if([writeCommd containsString:@"04"]) {
        if (![hexStr containsString:@"00000000000000000000000000000000"]) {
            if (prestcount<64) {
                prestcount++;
               if (![self.readPresetArr containsObject:[NSString stringWithFormat:@"%@=%@",characteristic.value,peripheral.identifier.UUIDString]]) {
                    [self.readPresetArr addObject:[NSString stringWithFormat:@"%@=%@",characteristic.value,peripheral.identifier.UUIDString]];
                }
               [ttt invalidate];
                ttt=nil;
                greenindexxx=0;
                offf=YES;
                [self PRESETINFO:peripheral];
            }
        } else {
            [self.m cancelPeripheralConnection:peripheral];
            prestcount=1;
            r++;
            [ttt invalidate];
            ttt=nil;
            greenindexxx=0;
            offf=YES;
            [self readPreset];
            NSLog(@"the preset is %@",hexStr);
            }
        } else  if([writeCommd containsString:@"03"]) {
            if (![hexStr containsString:@"00000000000000000000000000000000"]) {
                [self.m cancelPeripheralConnection:peripheral];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PresetSuccess" object:self userInfo:nil];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0)//OK button pressed
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"tableAftrRead"
         object:self userInfo:nil];    }
    else if(buttonIndex == 1)//Annul button pressed.
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"tableAftrRead"
         object:self userInfo:nil];    }
}
#pragma mark - CBCentralManager delegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
     NSString*sss=[NSString stringWithFormat:@"%ld",(long)central.state] ;
    if (central.state!= CBCentralManagerStatePoweredOn)
    {
        //        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BLE not supported !" message:[NSString stringWithFormat:@"CoreBluetooth return state: %d",central.state] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alertView show];
    }
    if ([sss isEqualToString:@"4"])
    {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BLE not supported !" message:[NSString stringWithFormat:@"CoreBluetooth return state: %ld",(long)central.state] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        
    }

    else {
       // [central scanForPeripheralsWithServices:@[ [CBUUID UUIDWithString:@"F000AA00-0451-4000-B000-000000000000"]] options:nil ];
        
        NSArray *services = @[[CBUUID UUIDWithString:SENSORTAG_SERVICE_UUID]];
        
      //  NSArray *peripherl = [central retrievePeripheralsWithIdentifiers:services];
        
       
        [central scanForPeripheralsWithServices:services options:nil];
        
        
    }
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error;
{

}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loaderForReading" object:self userInfo:nil];
    NSLog(@"advertisementData : %@",advertisementData);
    NSLog(@"serverId MAC ADDRESS %@", [peripheral identifier]);
    
    if ([[advertisementData valueForKey:@"kCBAdvDataLocalName"] isEqualToString:@"CC2650 SensorTag"]){
        [self.sensorTags addObject:peripheral];
        [peripheral setDelegate:self];
        [self.m connectPeripheral:peripheral options:nil];
        
        peripheral.delegate = self;
        [self.instrummetList addObject:peripheral.identifier.UUIDString];
        if([self.delegate respondsToSelector:@selector(devicesFound:)]) {
            [self.delegate devicesFound:self.instrummetList];
        }

        //[[NSNotificationCenter defaultCenter] postNotificationName:@"tableAftrRead" object:self userInfo:nil];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"tableAftrWrite" object:self userInfo:nil];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"clockReadFinished" object:self userInfo:nil];
    }
    
//    for(CBPeripheral *p  in self.sensorTags) {
//        p.delegate = self;
//        [self.instrummetList addObject:p.identifier.UUIDString];
//    }
//    if (self.sensorTags.count > 0) {
//        if ([readDevice isEqualToString:@"readDEV"]) {
//            [self performSelector:@selector(connectCommand) withObject:self afterDelay:3.1];
//            if([self.delegate respondsToSelector:@selector(devicesFound:)]) {
//                [self.delegate devicesFound:self.instrummetList];
//            }
//        } else  if ([readDevice isEqualToString:@"READPRESET"]) {
//        } else {
//            self.response_Arr=[[NSMutableArray alloc]init];
//            [self performSelector:@selector(connectClockID) withObject:self afterDelay:2.9f];
//        }
//    };
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"Peripheral Connected");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tableAftrRead" object:self userInfo:nil];
    
    if(self.discoverServicesAfterConnect == true) {
        [peripheral discoverServices:nil];
        self.discoverServicesAfterConnect = false;
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
       for (CBService *s in peripheral.services) {
           NSLog(@"servicessssensrr %@",s);
           [peripheral discoverCharacteristics:nil forService:s];
       }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:( NSError *)error{
    int enable = ENABLE_SENSOR_CODE;
    int frequency = 0x0A;
    NSData *enableData = [NSData dataWithBytes:&enable length: 1];
    NSData *frequencyData = [NSData dataWithBytes:&frequency length: 1];
    for (CBCharacteristic * characteristic in service.characteristics){
        
        NSLog(@"charcteristics %@",characteristic.UUID);
        NSString *cuuid=[NSString stringWithFormat:@"%@",characteristic.UUID];
        NSString *uid=[NSString stringWithFormat:@"%@",IODataUUID];
        NSString *uidIOConfigUUID=[NSString stringWithFormat:@"%@",IOConfigUUID];
        
        if ([cuuid containsString:@"0"]) {
            if ([cuuid isEqualToString:uid]){
                
                int  valueToWrite = 0;
                char* bytes = (char*) &valueToWrite;
                NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
                NSLog(@"bytes %s",bytes);
                NSLog(@"writeValueIO %@",writeValueIO);
                [peripheral writeValue:writeValueIO forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                IOCharacteristic = characteristic;
                [arrCHARCTERCITS setObject:characteristic forKey:peripheral];
            }
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_MOV_CONF]]){
                unsigned short e = 0;
                e |= FLAG_ACC_X | FLAG_ACC_Y | FLAG_ACC_Z | FLAG_GYRO_X | FLAG_GYRO_Y | FLAG_GYRO_Z | FLAG_MAG;
                switch (accRange) {
                    case ACC_RANGE_2G:
                        break;
                    case ACC_RANGE_4G:
                        e |= FLAG_ACC_RANGE_4G;
                        break;
                    case ACC_RANGE_8G:
                        e |= FLAG_ACC_RANGE_8G;
                        break;
                    case ACC_RANGE_16G:
                        e |= FLAG_ACC_RANGE_16G;
                        break;
                    default:
                        break;
                }
                
                NSLog(@"%d",e);
                NSData *ed = [NSData dataWithBytes:&e length: sizeof(e)];
                [peripheral writeValue:ed forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                [peripheral writeValue:frequencyData forCharacteristic:[self getCharateristicWithUUID:UUID_MOV_PERI from:service] type:CBCharacteristicWriteWithResponse];
                
                [peripheral setNotifyValue:YES forCharacteristic:[self getCharateristicWithUUID:UUID_MOV_DATA from:service]];
                
            }
            if ([cuuid isEqualToString:uidIOConfigUUID]){
                int enableValueIO = 1;
                char* bytes = (char*) &enableValueIO;
                NSData *enableBytesIO = [NSData dataWithBytes:bytes length:sizeof(UInt8)];
                [peripheral writeValue:enableBytesIO forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
           }
        }
    }
}
-(CBCharacteristic *) getCharateristicWithUUID:(NSString *)uuid from:(CBService *) cbService
{
    for (CBCharacteristic *characteristic in cbService.characteristics) {
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:uuid]]){
            return characteristic;
        }
    }
    return nil;
}
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if(error) {
        
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    // Exits if it's not the transfer characteristic
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        
        return;
    }
    // NSLog(@"Notification characteristic on %@",characteristic);
    // Notification has started
    if (characteristic.isNotifying) {
        
        
        [peripheral readValueForCharacteristic:characteristic];
        NSLog(@"Notification began on %@", characteristic.value);
          //[myPeripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
       
        
    } else { // Notification has stopped
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [self.m cancelPeripheralConnection:peripheral];
    }
    
   ////
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    NSLog(@"didWriteValueForCharacteristic %@ error = %@",characteristic,error);
    
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error {
    
    if (error == nil) {
        
        NSLog(@"THAPAP service: %@", [error localizedDescription]);
        // Starts advertising the service
        [myPeripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey:@"ICServer",CBAdvertisementDataServiceUUIDsKey:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]}];
        
        
    
    }

    if(error){
        
        NSLog(@"Error publishing service: %@", [error localizedDescription]);
    
    }
    
}
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    
    
    NSLog(@"Central subscribed to characteristic");
    
    // Get the data
    NSString *STRRSS=@"HI SHARAD THAPA";
    self.dataToSend = [STRRSS dataUsingEncoding:NSUTF8StringEncoding];
    
    // Reset the index
    self.sendDataIndex = 0;
    
    // Start sending
  //  [self sendData];
}
-(void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    // Start sending again
   // [self sendData];
    
}

-(void)sendDataToPeripheral
{
    //We're in CBPeripheralManagerStatePoweredOn state...
    NSLog(@"self.peripheralManager powered on.");
    // ... so build our service.
    
    NSMutableDictionary *getDic = [[NSMutableDictionary alloc] init];
    [getDic setObject:@"Morning Fav" forKey:@"Preset_name"];
    [getDic setObject:@"Thursday" forKey:@"Day"];
    [getDic setObject:@"9:30 am" forKey:@"Time_activation"];
    [getDic setObject:@"living room-tv" forKey:@"shutter_name"];
    [getDic setObject:@"27-1-2016" forKey:@"current_date"];
    
    NSData *datSend = [NSJSONSerialization dataWithJSONObject:getDic options:NSJSONWritingPrettyPrinted error:nil];
    NSUInteger len = [datSend length];
    Byte *byteData = (Byte*)malloc(len);
    memcpy(byteData, [datSend bytes],len);
    
    NSData *writeValueIO = [NSData dataWithBytes:byteData length:sizeof(UInt16)];
    NSLog(@"lenthhhhbytess %ld",writeValueIO.length);
    
    
    
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]
                                                                     properties:CBCharacteristicPropertyWrite
                                                                          value:datSend
                                                                    permissions:CBAttributePermissionsWriteable];
    
    CBMutableService *transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
                                                                       primary:YES];
    
   
    transferService.characteristics = @[self.transferCharacteristic];
    
    
    
    
    [myPeripheralManager addService:transferService];
    NSLog(@"the thapapapreripheral is %@",myPeripheralManager);

    [self.sensorTagPeripheral setNotifyValue:YES forCharacteristic:self.transferCharacteristic];
    
    [self.data appendData:self.transferCharacteristic.value];
    NSString *STRRRTR=[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"transfer charcteristics %@",self.transferCharacteristic);

    NSLog(@"got valueee %@",STRRRTR);
    
}
-(void)sendData
{
    // First up, check if we're meant to be sending an EOM
    
    static BOOL sendingEOM = NO;
    
    if (sendingEOM) {
        
        // send it
        
      //  BOOL didSend = [myPeripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        // Did it send?
      //  if (didSend) {
            
            // It did, so mark it as sent
         //   sendingEOM = NO;
            
         //   NSLog(@"Sent: EOM");
     //   }
        
        // It didn't send, so we'll exit and wait for peripheralManagerIsReadyToUpdateSubscribers to call sendData again
        return;
    }
    
    // We're not sending an EOM, so we're sending data
    
    // Is there any left to send?
    
    if (self.sendDataIndex >= self.dataToSend.length){
        
        // No data left.  Do nothing
    
        
    return;
        
    
    }
    
    // There's data left, so send until the callback fails, or we're done.
    
    BOOL didSend = YES;
    
    while (didSend) {
        
        // Make the next chunk
        
        // Work out how big it should be
        NSInteger amountToSend = self.dataToSend.length - self.sendDataIndex;
        
        // Can't be longer than 20 bytes
        
        
        // Copy out the data we want
      //  NSData *chunk = [NSData dataWithBytes:self.dataToSend.bytes+self.sendDataIndex length:amountToSend];
        
        // Send it
     //   didSend = [myPeripheralManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        // If it didn't work, drop out and wait for the callback
        
        if (!didSend) {
            return;
        }
        
       // NSString *stringFromData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
      //  NSLog(@"Sent: %@", stringFromData);
        
        // It did send, so update our index
       // self.sendDataIndex += amountToSend;
        
        // Was it the last one?
        if (self.sendDataIndex >= self.dataToSend.length){
            
            // It was - send an EOM
            
            // Set this so if the send fails, we'll send it next time
            sendingEOM = YES;
            
            // Send it
            BOOL eomSent = [myPeripheralManager updateValue:[@"00000010" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:IOCharacteristic onSubscribedCentrals:nil];
            
            if (eomSent) {
                // It sent, we're all done
                sendingEOM = NO;
                
                NSLog(@"Sent: EOM");
            }
            
            return;
        }
    }
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{

//    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
//    
//      
//    }
//
//    //We're in CBPeripheralManagerStatePoweredOn state...
//    NSLog(@"self.peripheralManager powered on.");
//    
//    // ... so build our service.
//    NSMutableDictionary *getDic = [[NSMutableDictionary alloc] init];
//    [getDic setObject:@"Morning Fav" forKey:@"Preset_name"];
//    [getDic setObject:@"Thursday" forKey:@"Day"];
//    [getDic setObject:@"17-12-2015" forKey:@"date"];
//    [getDic setObject:@"living room-tv" forKey:@"shutter_name"];
//   
//      NSData *datSend = [NSJSONSerialization dataWithJSONObject:getDic options:NSJSONWritingPrettyPrinted error:nil];
//   // NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSUInteger len = [datSend length];
//  
//    Byte *byteData = (Byte*)malloc(len);
//    memcpy(byteData, [datSend bytes], len);
//    
//      NSData *writeValueIO = [NSData dataWithBytes:byteData length:sizeof(UInt16)];
//      NSLog(@"lenthhhhbytess %ld",writeValueIO.length);
//    //char bytes = &getDic;
//   // NSData *writeValueIO = [NSData dataWithBytes:bytes length:sizeof(8)];
//   // NSData * datSend = [@"thapaa" dataUsingEncoding:NSUTF8StringEncoding];
//    // Start with the CBMutableCharacteristic
//    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]
//                                                                     properties:CBCharacteristicPropertyWrite
//                                                                          value:datSend
//                                                                    permissions:CBAttributePermissionsWriteable];
//    
////  // Then the serviceo[
//    CBMutableService *transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
//                                                                      primary:YES];
////    
////     //Add the characteristic to the service
//    transferService.characteristics = @[self.transferCharacteristic];
//
//    // And add it to the peripheral manager
//  
//     
//     //[myPeripheralManager addService:transferService];
//    NSLog(@"the thapapapreripheral is %@",myPeripheralManager);


}

-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error {

    if(error){
        
        NSLog(@"Error advertising: %@", [error localizedDescription]);
        
    }


}
-(void)peripheralManager:(CBPeripheralManager *)peripheral
    didReceiveReadRequest:(CBATTRequest *)request{
    if ([request.characteristic.UUID isEqual:myCharacteristic.UUID]) {
        if (request.offset > myCharacteristic.value.length) {
            [myPeripheralManager respondToRequest:request
                                       withResult:CBATTErrorInvalidOffset];
            request.value = [myCharacteristic.value
                             subdataWithRange:NSMakeRange(request.offset,
                                                          myCharacteristic.value.length - request.offset)];
            [myPeripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
            
            return;
            
        }
    }
}

@end
