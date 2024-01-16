// Created by udevs

import AppIntents
import Foundation

struct SetAutoBrightnessAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Set Auto Brightness"

	static let description = IntentDescription(
		"Set display auto brightness.",
		categoryName: "Utility",
		searchKeywords: [
			"screen",
            "display"
		]
	)

	@Parameter(
		title: "State",
		default: true
	)
	var state: Bool

	func perform() async throws -> some IntentResult {
        let handle = dlopen(FW_GraphicsServices, RTLD_LAZY)
        if handle != nil {
            CFPreferencesSetAppValue("BKEnableALS" as CFString, state ? kCFBooleanTrue : kCFBooleanFalse , "com.apple.backboardd" as CFString);
            CFPreferencesAppSynchronize("com.apple.backboardd" as CFString);
            GSSendAppPreferencesChanged("com.apple.backboardd" as CFString, "BKEnableALS" as CFString);
        } else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_GraphicsServices)] )
        }
        return .result()
	}
}
