//
//  Preset.h
//  OpenShutters
//
//  Created by Sharad Thapa on 11/07/16.
//  Copyright © 2016 Sharad Thapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preset : NSObject <NSCoding>

@property (strong, nonatomic) NSString *serial_number;
@property (nonatomic, strong)NSString *mottor;
@property (nonatomic, strong)NSString *hour;
@property (nonatomic, strong)NSString *min;
@property (nonatomic, strong)NSString *days;
@property (nonatomic, strong)NSString *name;
@property (strong, nonatomic)NSString *uuid_device;
@property (nonatomic)BOOL isUP;

@end
