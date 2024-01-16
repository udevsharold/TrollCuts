// Created by udevs

import AppIntents

struct GetBackupStateAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Get Backup State"

	static let description = IntentDescription(
		"Get iCloud backup state.",
		categoryName: "Utility",
		searchKeywords: [
			"icloud"
		]
	)

	func perform() async throws -> some IntentResult & ReturnsValue<Int> {
		let handle = dlopen(FW_MobileBackup, RTLD_LAZY)
		var state = -1
		if handle != nil {
			let mbManager = MBManager()
			state = Int(mbManager.backupState().state)
			dlclose(handle)
		} else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_MobileBackup)] )
        }
		return .result(value: state)
	}
}