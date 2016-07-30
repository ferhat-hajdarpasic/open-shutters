#import "sensorTagKeyService.h"
#import "sensorFunctions.h"
#import "masterUUIDList.h"

@implementation sensorTagKeyService

+(BOOL) isCorrectService:(CBService *)service {
    if ([service.UUID.UUIDString isEqualToString:TI_SIMPLE_KEYS_SERVICE]) {
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
            if ([c.UUID.UUIDString isEqualToString:TI_SIMPLE_KEYS_KEY_PRESS_STATE]) {
                self.data = c;
            }
        }
        if (!(self.data)) {
            NSLog(@"Some characteristics are missing from this service, might not work correctly !");
        }
    }
    return self;
}

-(BOOL) configureService {
    if (self.data) {
        [self.btHandle setNotifyStateForCharacteristic:self.data enable:YES];
    }
    return YES;
}

-(BOOL) deconfigureService {
    if (self.data) {
        [self.btHandle setNotifyStateForCharacteristic:self.data enable:NO];
    }
    return YES;
}


-(BOOL) dataUpdate:(CBCharacteristic *)c {
    if ([self.data isEqual:c]) {
        NSLog(@"sensorTagKeyService: Recieved value : %@",c.value);
        return YES;
    }
    return NO;
}

-(NSArray *) getCloudData {
    NSArray *ar = [[NSArray alloc]initWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:
                    //Value 1
                    [NSString stringWithFormat:@"%d",(self.key1) ? 1 : 0],@"value",
                    //Name 1
                    @"MQTT_RESOURCE_NAME_BUTTON_1",@"name", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:
                    //Value 1
                    [NSString stringWithFormat:@"%d",(self.key2) ? 1 : 0],@"value",
                    //Name 1
                    @"MQTT_RESOURCE_NAME_BUTTON_2",@"name", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:
                    //Value 1
                    [NSString stringWithFormat:@"%d",(self.reedRelay) ? 1 : 0],@"value",
                    //Name 1
                    @"MQTT_RESOURCE_NAME_REED_RELAY",@"name", nil],nil];
    return ar;
}

-(NSString *) calcValue:(NSData *) value {
    uint8_t dat[value.length];
    [value getBytes:dat length:value.length];
    if (dat[0] & 0x1) self.key1 = YES;
    else self.key1 = NO;
    if (dat[0] & 0x2) self.key2 = YES;
    else self.key2 = NO;
    if (dat[0] & 0x4) self.reedRelay = YES;
    else self.reedRelay = NO;
    return [NSString stringWithFormat:@"Key 1: %@, Key 2: %@, Reed Relay: %@",
            (self.key1) ? @"ON " : @"OFF",
            (self.key2) ? @"ON " : @"OFF",
            (self.reedRelay) ? @"ON " : @"OFF"];
}

@end
