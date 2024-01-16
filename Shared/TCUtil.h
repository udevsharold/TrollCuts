//Created by udevs

#ifndef TCUtil_h
#define TCUtil_h


#endif /* TCUtil_h */


#define FW_FrontBoardServices "/System/Library/PrivateFrameworks/FrontBoardServices.framework/FrontBoardServices"
#define FW_MobileBackup "/System/Library/PrivateFrameworks/MobileBackup.framework/MobileBackup"
#define FW_ManagedConfiguration "/System/Library/PrivateFrameworks/ManagedConfiguration.framework/ManagedConfiguration"
#define FW_GraphicsServices "/System/Library/PrivateFrameworks/GraphicsServices.framework/GraphicsServices"

#ifndef ROOTHELPER 
extern int switchAppRegistration(NSString* appPath, NSString* newState);
extern void switchAllAppsRegistration(NSString *newState, NSArray *excludeApps);
extern void setAutoLock(NSNumber *interval);
#endif
