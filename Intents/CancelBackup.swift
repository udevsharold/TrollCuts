// Created by udevs

import AppIntents

struct CancelBackupAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Cancel Backup"

	static let description = IntentDescription(
		"Cancel iCloud backup.",
		categoryName: "Utility",
		searchKeywords: [
			"icloud",
		]
	)

	func perform() async throws -> some IntentResult {
		let handle = dlopen(FW_MobileBackup, RTLD_LAZY)
		if handle != nil {
			let mbManager = MBManager()
			mbManager.cancel()
			dlclose(handle)
		} else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_MobileBackup)] )
        }
		return .result()
	}
}