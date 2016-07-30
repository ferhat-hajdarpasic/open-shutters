#import "sensorTagLightService.h"
#import "sensorFunctions.h"
#import "masterUUIDList.h"
#import "math.h"

@implementation sensorTagLightService

+(BOOL) isCorrectService:(CBService *)service {
    if ([service.UUID.UUIDString isEqualToString:TI_SENSORTAG_TWO_LIGHT_SENSOR_SERVICE]) {
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
            if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_TWO_LIGHT_SENSOR_CONFIG]) {
                self.config = c;
            }
            else if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_TWO_LIGHT_SENSOR_DATA]) {
                self.data = c;
            }
            else if ([c.UUID.UUIDString isEqualToString:TI_SENSORTAG_TWO_LIGHT_SENSOR_PERIOD]) {
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
        NSLog(@"sensorTagLightService: Recieved value : %@",c.value);
        return YES;
    }
    return NO;
}

-(NSArray *) getCloudData {
    NSArray *ar = [[NSArray alloc]initWithObjects:
          [NSDictionary dictionaryWithObjectsAndKeys:
           //Value 1
           [NSString stringWithFormat:@"%0.1f",self.lightLevel],@"value",
           //Name 1
           @"MQTT_RESOURCE_NAME_LIGHT_LEVEL",@"name", nil], nil];
    return ar;
}

-(NSString *) calcValue:(NSData *) value {
    unsigned char tmp[value.length];
    [value getBytes:tmp length:value.length];
    uint16_t dat;
    dat = ((uint16_t)tmp[1] & 0xFF) << 8;
    dat |= (uint16_t)(tmp[0] & 0xFF);
    
    self.lightLevel = (float)[sensorTagLightService sfloatExp2ToDouble:dat];
    
    
    
    return [NSString stringWithFormat:@"Amb: %0.1f Lux",(float)self.lightLevel];
}

+(double) sfloatExp2ToDouble:(uint16_t) sfloat {
    uint16_t mantissa;
    uint8_t exponent;
    
    mantissa = sfloat & 0x0FFF;
    exponent = sfloat >> 12;
#ifdef SIGNED
    if (exponent >= 0x0008) {
        exponent = -((0x000F + 1) - exponent);
    }
#endif
#ifdef SIGNED
    if (mantissa >= 0x0800) {
        mantissa = -((0x0FFF + 1) - mantissa);
    }
#endif
    double output;
    double magnitude = pow(2.0f, exponent);
    output = (mantissa * magnitude);
    
    return output / 100.0f;
}


@end
