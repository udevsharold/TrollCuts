//Created by udevs

import AppIntents

struct SetLocationServicesAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Set Location Services"

	static let description = IntentDescription(
		"Set location services status.",
		categoryName: "Location",
		searchKeywords: [
			"gps",
		]
	)

    @Parameter(title: "State", default: .on)
	var state: SwitchStateAppEnum

	static var parameterSummary: some ParameterSummary {
		Summary("Set location services \(\.$state)")
	}

	func perform() async throws -> some IntentResult {
		let handle = dlopen(FW_CoreLocation, RTLD_LAZY)
        if handle != nil {
            CLLocationManager.setLocationServicesEnabled(state.rawValue == "on")
			dlclose(handle)
		} else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_CoreLocation)] )
        }
        return .result()
	}
}