#import "sensorTagAmbientTemperatureService.h"
#import "sensorFunctions.h"
#import "masterUUIDList.h"

@implementation sensorTagAmbientTemperatureService

+(BOOL) isCorrectService:(CBService *)service {
    if ([service.UUID.UUIDString isEqualToString:TI_SENSORTAG_TEMPERATURE_SERVICE]) {
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
            if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_IR_TEMPERATURE_CONFIG]) {
                self.config = c;
            }
            else if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_IR_TEMPERATURE_DATA]) {
                self.data = c;
            }
            else if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_IR_TEMPERATURE_PERIOD]) {
                self.period = c;
            }
        }
        if (!(self.config && self.data && self.period)) {
            NSLog(@"Some characteristics are missing from this service, might not work correctly !");
        }
    }
    return self;
}

-(BOOL) dataUpdate:(CBCharacteristic *)c {
    if ([self.data isEqual:c]) {
        NSLog(@"sensorTagAmbientTemperatureService: Recieved value : %@",c.value);
        return YES;
    }
    return NO;
}

-(NSArray *) getCloudData {
    NSArray *ar = [[NSArray alloc]initWithObjects:
          [NSDictionary dictionaryWithObjectsAndKeys:
           //Value 1
           [NSString stringWithFormat:@"%0.1f",self.ambientTemperature],@"value",
           //Name 1
           @"MQTT_RESOURCE_NAME_AMBIENT_TEMPERATURE",@"name", nil],
           //Value 2
          [NSDictionary dictionaryWithObjectsAndKeys:
           [NSString stringWithFormat:@"%0.1f",self.objectTemperature],@"value",
           //Name 2
           @"MQTT_RESOURCE_NAME_OBJECT_TEMPERATURE",@"name", nil], nil];
    return ar;
}

-(NSString *) calcValue:(NSData *) value {
    char scratchVal[value.length];
    int16_t ambTemp;
    int16_t objTemp;
    float tObj;
    //Ambient temperature first
    [value getBytes:&scratchVal length:value.length];
    ambTemp = ((scratchVal[2] & 0xff)| ((scratchVal[3] << 8) & 0xff00));
    //Then object temperature
    objTemp = ((scratchVal[0] & 0xff)| ((scratchVal[1] << 8) & 0xff00));
    objTemp >>= 2;
    tObj = ((float)objTemp) * 0.03125;
    
    self.objectTemperature = tObj;
    self.ambientTemperature = ambTemp / 128.0f;
    
    return [NSString stringWithFormat:@"Amb: %0.1f°C, Obj: %0.1f°C",self.ambientTemperature,self.objectTemperature];
}

@end
