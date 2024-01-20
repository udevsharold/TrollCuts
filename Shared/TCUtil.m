//Created by udevs

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <notify.h>
#import "PrivateHeader.h"
#import "TCUtil.h"
#import "TSUtil.h"
#import "locsim.h"

int switchAppRegistration(NSString* appPath, NSString* newState){
    if(!appPath || !newState) return -200;
    NSString *tsRootHelperPath = [trollStoreAppPath() stringByAppendingPathComponent:@"trollstorehelper"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:tsRootHelperPath]){
        return spawnRoot(tsRootHelperPath, @[@"modify-registration", appPath, newState], nil, nil);
    }
    return -1;
}

void switchAllAppsRegistration(NSString *newState, NSArray *excludeApps){
    if(!newState) return;
	for(NSString* appPath in trollStoreInstalledAppBundlePaths()){
        if ([excludeApps containsObject:[appPath lastPathComponent]]) continue;
        switchAppRegistration(appPath, newState);
	}
}

void setAutoLock(NSNumber *interval){
    spawnRoot(rootHelperPath(), @[interval], nil, nil);
}

NSArray<NSNumber *> *parseCoorString(NSString *coor){
    coor = [[coor componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()[]"]] componentsJoinedByString: @""];
    NSArray *components = [coor componentsSeparatedByString:@","];
    if (components.count >= 2){
        return @[@([components.firstObject doubleValue]), @([components.lastObject doubleValue])];
    }
    return nil;
}

int startLocSim(double lat, double lon, double alt, double ha, double va){
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(lat, lon);
    if (!CLLocationCoordinate2DIsValid(coor)) return 1;
    CLLocation *loc;
    NSDate *ts = [NSDate date];
    if (@available(iOS 13.4, *)){
        loc = [[CLLocation alloc] initWithCoordinate:coor altitude:alt horizontalAccuracy:ha verticalAccuracy:va course:-1.0 courseAccuracy:-1.0 speed:0.0 speedAccuracy:-1.0 timestamp:ts];
    }else{
        loc = [[CLLocation alloc] initWithCoordinate:coor altitude:alt horizontalAccuracy:ha verticalAccuracy:va course:-1.0 speed:0.0 timestamp:ts];
    }
    start_loc_sim(loc, -1, -1);
    return 0;
}

void stopLocSim(BOOL force){
    if (force){
        killall(@"locationd", NO);
    }else{
        stop_loc_sim();
    }
}

#define RINGERSTATE_NOTI_NAME "com.apple.springboard.ringerstate"
uint32_t getRingerState() {
  int token = -1;
  uint64_t state = -1;
  notify_register_check(RINGERSTATE_NOTI_NAME, &token);
  if (token != -1){
    notify_get_state(token, &state);
  }
  return (uint32_t)state;
}

int setRingerState(int state) {
  int token = -1;
  notify_register_check(RINGERSTATE_NOTI_NAME, &token);
  if (token != -1){
    notify_set_state(token, state);
    notify_post(RINGERSTATE_NOTI_NAME);
    return 0;
  }
  return 1;
}