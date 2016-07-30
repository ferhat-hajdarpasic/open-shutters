#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad


#define DevicesNamedList @"deviceslistt"
#define PerpheralNamedList @"peripheralistt"
#define NAME_SHUTTER_SIDE_BAR_TAG 9999
#define HOW_APP_WORKS_TAG 8888
#define RESTORE_SETTINGS_TAG 7777
#define SHUTTER_UP @"UPMOVEMENT"
#define SHUTTER_DOWN @"DOWNPMOVEMENT"
#define FIRST_TIME_SCREEN @"ONLYONCE"
#define TRANSFER_SERVICE_UUID           @"F000AA00-0451-4000-B000-000000000000"
#define TRANSFER_CHARACTERISTIC_UUID    @"F000AA01-0451-4000-B000-000000000000"
#define ENABLE_SENSOR_CODE 1

//#define TRANSFER_SERVICE_UUID           @"8BD7C7C5-AD06-4698-A075-15BD553E18E1"
//#define TRANSFER_CHARACTERISTIC_UUID    @"F4ADA99C-6574-4790-A0CF-90668603D555"

#define IS_IPHONE [[UIScreen mainScreen ] bounds].size.height == 480.0f
#define IS_IPOD   ( [[[UIDevice currentDevice ] model] isEqualToString:@"iPod touch"])
#define IS_HEIGHT_4s[[UIScreen mainScreen ] bounds].size.height == 480.0f
#define IS_IPHONE_5 [[UIScreen mainScreen ] bounds].size.height==568.0f

