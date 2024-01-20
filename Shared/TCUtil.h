//Created by udevs

#ifndef TCUtil_h
#define TCUtil_h


#endif /* TCUtil_h */


#define FW_FrontBoardServices "/System/Library/PrivateFrameworks/FrontBoardServices.framework/FrontBoardServices"
#define FW_MobileBackup "/System/Library/PrivateFrameworks/MobileBackup.framework/MobileBackup"
#define FW_ManagedConfiguration "/System/Library/PrivateFrameworks/ManagedConfiguration.framework/ManagedConfiguration"
#define FW_GraphicsServices "/System/Library/PrivateFrameworks/GraphicsServices.framework/GraphicsServices"
#define FW_CoreLocation "/System/Library/Frameworks/CoreLocation.framework/CoreLocation"

extern int switchAppRegistration(NSString* appPath, NSString* newState);
extern void switchAllAppsRegistration(NSString *newState, NSArray *excludeApps);
extern void setAutoLock(NSNumber *interval);
NSArray<NSNumber *> *parseCoorString(NSString *coor);
int startLocSim(double lat, double lon, double alt, double ha, double va);
void stopLocSim(BOOL force);
uint32_t getRingerState();
int setRingerState(int state);
