// Created by udevs

import AppIntents

struct RebootAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Reboot"

	static let description = IntentDescription(
		"Reboot device.",
		categoryName: "Device"
	)

	func perform() async throws -> some IntentResult{
		let handle = dlopen(FW_FrontBoardServices, RTLD_LAZY)
		if handle != nil {
			FBSSystemService.shared().reboot()
			dlclose(handle)
		} else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_FrontBoardServices)] )
        }
		return .result()
	}
}