// Created by udevs

import AppIntents

struct GetRingerStateAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Get Ringer State"

	static let description = IntentDescription(
		"Get ringer switch state.",
		categoryName: "Utility",
		searchKeywords: [
			"sound",
            "ringtone",
			"mute"
		]
	)

	func perform() async throws -> some IntentResult & ReturnsValue<Int>  {
        let state = getRingerState()
        return .result(value: Int(state))
	}
}
