// Created by udevs

import AppIntents

struct SetRingerStateAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Set Ringer"

	static let description = IntentDescription(
		"Set ringer switch state programmatically.",
		categoryName: "Utility",
		searchKeywords: [
			"sound",
            "ringtone",
			"mute"
		]
	)

	@Parameter(title: "State", default: .on)
	var state: SwitchStateAppEnum

	static var parameterSummary: some ParameterSummary {
		Summary("Set Ringer \(\.$state)")
	}

	func perform() async throws -> some IntentResult & ReturnsValue<Int> {
    	let ret = setRingerState(state.rawValue == "on" ? 1 : 0)
        return .result(value: Int(ret))
	}
}
