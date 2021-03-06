//
//  SensorTagApplicationViewController.h
//
//  Created by Ole Andreas Torvmark on 9/25/12.
//  Copyright (c) 2012 Texas Instruments. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLEDevice.h"
#import "BLEUtility.h"
#import "deviceCellTemplate.h"
#import "Sensors.h"


#define MIN_ALPHA_FADE 0.2f
#define ALPHA_FADE_STEP 0.05f

@interface SensorTagApplicationViewController : UITableViewController <CBCentralManagerDelegate,CBPeripheralDelegate>

@property (strong,nonatomic) BLEDevice *d;
@property NSMutableArray *sensorsEnabled;
@property (strong,nonatomic) temperatureCellTemplate *ambientTemp;
@property (strong,nonatomic) temperatureCellTemplate *irTemp;
@property (strong,nonatomic) accelerometerCellTemplate *acc;
@property (strong,nonatomic) temperatureCellTemplate *rH;
@property (strong,nonatomic) accelerometerCellTemplate *mag;
@property (strong,nonatomic) sensorMAG3110 *magSensor;
@property (strong,nonatomic) temperatureCellTemplate *baro;
@property (strong,nonatomic) sensorC953A *baroSensor;
@property (strong,nonatomic) accelerometerCellTemplate *gyro;
@property (strong,nonatomic) sensorIMU3000 *gyroSensor;



-(id) initWithStyle:(UITableViewStyle)style andSensorTag:(BLEDevice *)andSensorTag;
-(void) configureSensorTag;
-(void) deconfigureSensorTag;
- (IBAction) handleCalibrateMag;
- (IBAction) handleCalibrateGyro;
-(void) alphaFader:(NSTimer *)timer;

@end
