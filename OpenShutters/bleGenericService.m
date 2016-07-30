#import "bleGenericService.h"
#import "sensorFunctions.h"

@implementation bleGenericService



///Check if the service is correct for this class
+(BOOL) isCorrectService:(CBService *)service {
    return NO;
}


///Initialize with a fully scanned CBService
-(instancetype) initWithService:(CBService *)service {
    self = [super init];
    if (self) {
        self.service = service;
    }
    return self;
}

-(NSArray *) getCloudData {
    return nil;
}
-(BOOL) dataUpdate:(CBCharacteristic *)c {
    NSLog(@"Data update : %@",c.value);
    return YES;
}

-(BOOL) configureService {
    BOOL ok = YES;
    if (self.config) {
        [self.btHandle writeValue:[sensorFunctions dataForEnable:YES forService:self.service.UUID.UUIDString] toCharacteristic:self.config];
    }
    else ok = NO;
    if (self.period) {
        [self.btHandle writeValue:[sensorFunctions dataForPeriod:1000] toCharacteristic:self.period];
    }
    else ok = NO;
    if (self.data) {
        [self.btHandle setNotifyStateForCharacteristic:self.data enable:YES];
    }
    else ok = NO;
    return ok;
}

-(BOOL) deconfigureService {
    BOOL ok = YES;
    if (self.config) {
        [self.btHandle writeValue:[sensorFunctions dataForEnable:NO forService:self.service.UUID.UUIDString] toCharacteristic:self.config];
    }
    else ok = NO;
    if (self.data) {
        [self.btHandle setNotifyStateForCharacteristic:self.data enable:NO];
    }
    else ok = NO;
    return ok;
}

-(void) wroteValue:(CBCharacteristic *)c error:(NSError *)error {
    if (error) {
        NSLog(@"Write failed to %@ with error:%@",c.UUID.UUIDString,error);
    }
    else {
        NSLog(@"Wrote %@",c.UUID);
    }
}
-(NSString *) calcValue:(NSData *) value {
    return @"Value";
}

@end
