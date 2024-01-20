// Created by udevs

import AppIntents

struct LockAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Lock"

	static let description = IntentDescription(
		"Lock device.",
		categoryName: "Device"
	)

	func perform() async throws -> some IntentResult {
		let handle = dlopen(FW_ManagedConfiguration, RTLD_LAZY)
		if handle != nil {
            MCProfileConnection.shared().lockDevice()
			dlclose(handle)
		} else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_ManagedConfiguration)] )
        }
		return .result()
	}
}