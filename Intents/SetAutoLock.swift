// Created by udevs

import AppIntents

struct SetAutoLockAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Set Auto-Lock"

	static let description = IntentDescription(
		"Set display auto-lock duration.",
		categoryName: "Utility",
		searchKeywords: [
			"screen",
            "display"
		]
	)

    @Parameter(title: "Duration", default: .halfsec)
	var duration: AutoLockDurationAppEnum

	func perform() async throws -> some IntentResult{
		let handle = dlopen(FW_ManagedConfiguration, RTLD_LAZY)
        var value: Int32 = 0
        if handle != nil {
            switch duration {
                case .halfsec:
                    value = 30
                case .onemin:
                    value = 60
                case .twomin:
                    value = 120
                case .threemin:
                    value = 180
                case .fourmin:
                    value = 240
                case .fivemin:
                    value = 300
                case .never:
                    value = Int32.max
            }
            MCProfileConnection.shared().setValue(NSNumber(value: value), forSetting: "maxInactivity")
			dlclose(handle)
		} else {
            throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: String(format: "Failed to load %@", FW_ManagedConfiguration)] )
        }
        return .result()
	}
}

enum AutoLockDurationAppEnum: String, AppEnum {
	case halfsec
	case onemin
    case twomin
    case threemin
    case fourmin
    case fivemin
    case never

	static let typeDisplayRepresentation: TypeDisplayRepresentation = "Auto-Lock Duration"

	static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
		.halfsec: "30 seconds",
		.onemin: "1 minute",
        .twomin: "2 minutes",
		.threemin: "3 minutes",
		.fourmin: "4 minutes",
		.fivemin: "5 minutes",
		.never: "Never"

	]
}