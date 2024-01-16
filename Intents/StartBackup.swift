// Created by udevs

import AppIntents

struct StartBackupAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Start Backup"

	static let description = IntentDescription(
		"Start iCloud backup.",
		categoryName: "Utility",
		searchKeywords: [
			"icloud"
		]
	)

	func perform() async throws -> some IntentResult & ReturnsValue<Bool> {
		let handle = dlopen(FW_MobileBackup, RTLD_LAZY)
		var isSuccess = false
		if handle != nil {
			let mbManager = MBManager()
			if mbManager.isBackupEnabled() {
				isSuccess = mbManager.startBackupWithError(nil)
			}
			dlclose(handle)
		} else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_MobileBackup)] )
        }
		return .result(value: isSuccess)
	}
}
