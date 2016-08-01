//
//  VerifyMobile.h
//  Unninr
//
//  Created by Sharad Thapa on 23/04/15.
//  Copyright (c) 2015 Sharad Thapa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEDevice.h"
#import "CustomSensorDelegate.h"
#import <UIKit/UIKit.h>
@interface CustomSensor:NSObject<CBCentralManagerDelegate,CBPeripheralDelegate,CBPeripheralManagerDelegate>
{
   
    
    BOOL WRITE;
    CBUUID * IRTemperatureServiceUUID;
    CBUUID * IRTemperatureDataUUID ;
    CBUUID * IRTemperatureConfigUUID ;
    CBCharacteristic *  IOCharacteristic;
    CBMutableCharacteristic *  myCharacteristic;
    CBUUID *IOServiceUUID ;          //    = CBUUID(string: "F000AA64-0451-4000-B000-000000000000")
    CBUUID *IODataUUID  ;              //  = CBUUID(string: "F000AA65-0451-4000-B000-000000000000")
    CBUUID *IOConfigUUID  ;           //   = CBUUID(string: "F000AA66-0451-4000-B000-000000000000")
    CBPeripheralManager * myPeripheralManager;
    CBUUID *myCustomServiceUUID ;
    CBMutableService *myService;
    int greenindexxx,greenindexxx1,r,prestcount;
    NSTimer *ttt,*ttt1,*ReadTime;
    BOOL offf;
    NSString *uuid_peripheral;
    NSMutableDictionary *arrCHARCTERCITS;
    int globalcounttp;
    NSString *readDevice;
    bool clockUpadte;
}
-(void)clock;
-(void)connectClockID;
-(void)sendPresets:(NSDictionary *)dicttnry newPreset:(NSString *)newpreset;
-(void)readPreset:(BOOL)connect UUID:(NSString *)UNIQUEID presetshutter:(NSString *)psss on:(BOOL)onnn;
-(void)sendDataToPeripheral2;
-(void)sendDataToPeripheral;
-(void)readMotor;

@property (strong, nonatomic) NSData                    *dataToSend;
@property (nonatomic, readwrite) NSInteger              sendDataIndex;
@property (strong, nonatomic) CBCharacteristic   *transferCharacteristic;
@property (strong, nonatomic) NSMutableData *data;
@property (nonatomic)BOOL isUP;
@property (nonatomic)BOOL isDown;
@property (strong,nonatomic) NSMutableArray *instrummetList;
@property (strong,nonatomic) CBCentralManager *m;
@property (strong,nonatomic) NSMutableArray *nDevices;
@property (strong,nonatomic) NSMutableArray *Peripheral_arr;
@property (strong,nonatomic) NSMutableArray *sensorTags;
@property (strong,nonatomic) NSMutableArray *writeCommandArr;;
@property (strong,nonatomic) CBPeripheral *sensorTagPeripheral;
@property (strong,nonatomic) NSMutableArray *response_Arr;
@property (strong,nonatomic) NSMutableArray *readPresetArr;
@property (strong,nonatomic) NSMutableArray *calibertaedPresetArr;
@property (nonatomic,weak)id <CustomSensorDelegate> delegate;
@property (nonatomic)BOOL discoverServicesAfterConnect;
@property (nonatomic)int clockSetResponseCount;
@property (nonatomic)int nameSetResponseCount;

+ (id)sharedCustomSensor;
-(void)lightGreenOn:(NSString *)blade;
-(void)lightGreenOff;
-(void)lightRedOn:(NSString *)blade;
-(void)lightRedOff;
-(void)ConnectWithServices;
-(void)connect:(BOOL)connect UUID:(NSString *)UNIQUEID presetshutter:(NSString *)psss on:(BOOL)onnn;
-(void)counterUpload:(BOOL)connect UUID:(NSString *)UNIQUEID presetshutter:(NSString *)psss on:(BOOL)onnn;
-(void)counterUploadshuttr:(BOOL)connect UUID:(NSString *)UNIQUEID presetshutter:(NSString *)psss on:(BOOL)onnn;

@end
