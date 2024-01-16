//Created by udevs

#import <Foundation/Foundation.h>
#import "TCUtil.h"
#import "TSUtil.h"

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