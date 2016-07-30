#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "bluetoothHandler.h"

typedef struct Point3D_ {
    CGFloat x,y,z;
} Point3D;


///@brief The bleGenericService class is the top level class for a bluetooth service in SensorTag2-example application.
/// It contains the basic functionality for enabling and disabling SensorTag services.\n\n
/// All the SensorTag 2 service abide to the following logic when it comes to characteristics:
/// - \b Config \b characteristic
///   - Turns the related sensor on/off and configures modes
/// - \b Period \b characteristic
///   - Sets the period in which the sensor value is refreshed and notified to host
/// - \b Data \b characteristic
///   - All data from sensor is transferred through the data characteristic
///
/// Configuration of a sensor is normally done in this way :
/// -# Write 0x01 (ON) to config characteristic
/// -# Write period 0x64 (100 * 10ms = 1000ms) register with desired period (1s for most sensors)
/// -# Enable notifications on data characteristic
///
/// Deconfiguration of a sensor is normally done in this way :
/// -# Enable notifications on data characteristic
/// -# Write 0x01 (ON) to config characteristic
///
/// \b MQTT \b support
/// All the services have a getCloudData function, this function retrieves an array with
/// dictionaries containing "name" and "value" pairs for the current data of the service.
/// The names used here are sourced from the masterMQTTResourceList.h file.
/// This value is then sourced to the IBM IoT quickstart cloud function once a second.
/// 


@interface bleGenericService : NSObject

///The service
@property CBService *service;
///The configuration characteristic for this service
@property CBCharacteristic *config;
///The data characteristic for this service
@property CBCharacteristic *data;
///The period characteristic for this service
@property CBCharacteristic *period;
///The shared instance bluetooth handler
@property bluetoothHandler *btHandle;

///Check if the service is correct for this class
+(BOOL) isCorrectService:(CBService *)service;


///Initialize with a fully scanned CBService
-(instancetype) initWithService:(CBService *)service;

///Returns array with dictionaries containing current cloud data
-(NSArray *) getCloudData;

///Called by main program when a data update is received from BLE
-(BOOL) dataUpdate:(CBCharacteristic *)c;

///Called when service is discovered to configure the characteristic
-(BOOL) configureService;

///Called when service is to deconfigure the characteristic
-(BOOL) deconfigureService;
///Called when a value was written to the device
-(void) wroteValue:(CBCharacteristic *)c error:(NSError *)error;

@end
