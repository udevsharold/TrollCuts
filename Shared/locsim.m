//Created by udevs

#import "PrivateHeader.h"
#import <CoreLocation/CoreLocation.h>

// from https://github.com/udevsharold/locsim
static void post_required_timezone_update(){
	//try our best to update time zone instantly, though it totally depends on whether xpc server (locationd) did update the location before we post this, especially with stop_loc_sim()
	CFNotificationCenterPostNotificationWithOptions(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("AutomaticTimeZoneUpdateNeeded"), NULL, NULL, kCFNotificationDeliverImmediately);
}

void start_loc_sim(CLLocation *loc, int delivery, int repeat){
	CLSimulationManager *simManager = [[CLSimulationManager  alloc] init];
	if (delivery >= 0) simManager.locationDeliveryBehavior = (uint8_t)delivery;
	if (repeat >= 0) simManager.locationRepeatBehavior = (uint8_t)repeat;
	[simManager stopLocationSimulation];
	[simManager clearSimulatedLocations];
	[simManager appendSimulatedLocation:loc];
	[simManager flush];
	[simManager startLocationSimulation];
	post_required_timezone_update();
}

void stop_loc_sim(){
	CLSimulationManager *simManager = [[CLSimulationManager  alloc] init];
	[simManager stopLocationSimulation];
	[simManager clearSimulatedLocations];
	[simManager flush];
	post_required_timezone_update();
}