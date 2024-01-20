//Created by udevs

import AppIntents

struct StartLocationSimulationAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Start Location Simulation"

	static let description = IntentDescription(
		"Simulate GPS location to specified coordinate.",
		categoryName: "Location",
		searchKeywords: [
			"gps",
            "locsim",
            "simulate"
		]
	)

	@Parameter(title: "Coordinate")
	var coordinate: String

	@Parameter(title: "Altitude", default: 0.0)
	var alt: Double

	@Parameter(title: "Horizontal Accuracy", default: 0.0)
	var ha: Double

	@Parameter(title: "Vertical Accuracy", default: 0.0)
	var va: Double

	static var parameterSummary: some ParameterSummary {
		Summary("Set location to \(\.$coordinate)"){
            \.$alt
            \.$ha
            \.$va
        }
	}

	func perform() async throws -> some IntentResult {
		let handle = dlopen(FW_CoreLocation, RTLD_LAZY)
        if handle != nil {
			// Don't need to tell me how much I suck in swift, I knows
			let coor = parseCoorString(coordinate).compactMap({ $0 as? Double })
			if coor == nil {
                throw NSError(domain: "TrollCuts", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to parse coordinate input" ])
			}
            let ret = startLocSim(coor[0], coor[1], alt, ha, va)
			dlclose(handle)
            if ret != 0 {
                throw NSError(domain: "TrollCuts", code: 1, userInfo: [NSLocalizedDescriptionKey: String(format: "Invalid coordinate: %d, %d", coor[0], coor[1])] )
            }
		} else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_CoreLocation)] )
        }
        return .result()
	}
}