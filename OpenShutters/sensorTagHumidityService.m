#import "sensorTagHumidityService.h"
#import "sensorFunctions.h"
#import "masterUUIDList.h"

@implementation sensorTagHumidityService

+(BOOL) isCorrectService:(CBService *)service {
    if ([service.UUID.UUIDString isEqualToString:TI_SENSORTAG_HUMIDTIY_SERVICE]) {
        return YES;
    }
    return NO;
}


-(instancetype) initWithService:(CBService *)service {
    self = [super initWithService:service];
    if (self) {
        self.btHandle = [bluetoothHandler sharedInstance];
        self.service = service;
        
        for (CBCharacteristic *c in service.characteristics) {
            if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_HUMIDTIY_CONFIG]) {
                self.config = c;
            }
            else if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_HUMIDTIY_DATA]) {
                self.data = c;
            }
            else if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_HUMIDTIY_PERIOD]) {
                self.period = c;
            }
        }
        if (!(self.config && self.data && self.period)) {
            NSLog(@"Some characteristics are missing from this service, might not work correctly !");
        }
    }
    return self;
}

-(BOOL) configureService {
    [super configureService];
    return YES;
}

-(BOOL) dataUpdate:(CBCharacteristic *)c {
    if ([self.data isEqual:c]) {
        NSLog(@"sensorTagHumidityService: Recieved value : %@",c.value);
        return YES;
    }
    return NO;
}

-(NSArray *) getCloudData {
    NSArray *ar = [[NSArray alloc]initWithObjects:
          [NSDictionary dictionaryWithObjectsAndKeys:
           //Value 1
           [NSString stringWithFormat:@"%0.1f",self.humidity],@"value",
           //Name 1
           @"MQTT_RESOURCE_NAME_HUMIDITY",@"name", nil], nil];
    return ar;
}

-(NSString *) calcValue:(NSData *) value {
    char scratchVal[value.length];
    [value getBytes:&scratchVal length:value.length];
    UInt16 hum;
    hum = (scratchVal[2] & 0xff) | ((scratchVal[3] << 8) & 0xff00);
    self.humidity = (float)((float)hum/(float)65535) * 100.0f;
    return [NSString stringWithFormat:@"Humidity: %0.1f%%rH",(float)self.humidity];
}

@end
