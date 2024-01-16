//Created by udevs

import AppIntents

struct RespringAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Respring"

	static let description = IntentDescription(
		"Respring device.",
		categoryName: "Device"
	)

	func perform() async throws -> some IntentResult {
        let background = DispatchQueue.global()
        background.async {
            respring()
        } 
        return .result()
	}
}
