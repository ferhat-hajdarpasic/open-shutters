//
//  Preset.m
//  OpenShutters
//
//  Created by Sharad Thapa on 11/07/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//

#import "Preset.h"
@implementation Preset
#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.serial_number = [decoder decodeObjectForKey:@"serial_number"];
    self.mottor = [decoder decodeObjectForKey:@"mottor"];
    self.hour = [decoder decodeObjectForKey:@"hour"];
    self.min = [decoder decodeObjectForKey:@"min"];
    self.days = [decoder decodeObjectForKey:@"days"];
    self.name = [decoder decodeObjectForKey:@"name"];
    self.uuid_device = [decoder decodeObjectForKey:@"uuid_device"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.serial_number forKey:@"serial_number"];
    [encoder encodeObject:self.mottor forKey:@"mottor"];
    [encoder encodeObject:self.hour forKey:@"hour"];
    [encoder encodeObject:self.min forKey:@"min"];
    [encoder encodeObject:self.days forKey:@"days"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.uuid_device forKey:@"uuid_device"];

}

@end
