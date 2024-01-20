//Created by udevs

#ifndef PrivateHeader_h
#define PrivateHeader_h


#endif /* PrivateHeader_h */

@import Foundation;
@import CoreLocation;

void GSSendAppPreferencesChanged(CFStringRef bundleID, CFStringRef key);

@interface MBStateInfo : NSObject
@property (assign,nonatomic) int state;
@property (assign,nonatomic) float progress; 
@property (assign,nonatomic) unsigned long long estimatedTimeRemaining;
@property (assign,nonatomic) BOOL isCloud; 
@property (assign,nonatomic) BOOL isBackground;
@end

@interface MBManager : NSObject
-(void)rebootDevice;
-(BOOL)startBackupWithError:(_Nullable id*)arg1 ;
-(void)cancel;
-(BOOL)isBackupEnabled;
-(MBStateInfo *)backupState;
@end

@interface FBSSystemService : NSObject
+(instancetype)sharedService;
-(void)reboot;
-(void)shutdown;
@end

@interface MCProfileConnection : NSObject
+ (instancetype)sharedConnection;
- (void)lockDevice;
- (void)lockDeviceImmediately:(bool)arg1;
- (void)setValue:(id)arg1 forSetting:(id)arg2 ;
- (void)_createAndResumeXPCConnection;
@end

@interface MCRestrictionManager : NSObject
+(id)defaultValueForSetting:(id)arg1 ;
+(id)minimumValueForSetting:(id)arg1 ;
+(id)maximumValueForSetting:(id)arg1 ;
@end

@interface CLLocationManager (Private)
+ (void)setLocationServicesEnabled:(bool)arg1;
@end

@interface CLSimulationManager : NSObject
@property (assign,nonatomic) uint8_t locationDeliveryBehavior;
@property (assign,nonatomic) double locationDistance;
@property (assign,nonatomic) double locationInterval;
@property (assign,nonatomic) double locationSpeed;
@property (assign,nonatomic) uint8_t locationRepeatBehavior;
-(void)clearSimulatedLocations;
-(void)startLocationSimulation;
-(void)stopLocationSimulation;
-(void)appendSimulatedLocation:(id)arg1 ;
-(void)flush;
-(void)loadScenarioFromURL:(id)arg1 ;
-(void)setSimulatedWifiPower:(BOOL)arg1 ;
-(void)startWifiSimulation;
-(void)stopWifiSimulation;
-(void)setSimulatedCell:(id)arg1 ;
-(void)startCellSimulation;
-(void)stopCellSimulation;
@end