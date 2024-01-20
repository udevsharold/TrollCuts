//Created by udevs

import AppIntents

struct SwitchAppsRegistrationAppIntent: AppIntent {
	static let title: LocalizedStringResource = "Switch Apps Registration State"

	static let description = IntentDescription(
		"Switch all TrollStore installed apps registration state.",
		categoryName: "TrollStore",
		searchKeywords: [
			"trollstore",
			"system",
			"user",
            "registration"
		]
	)

	@Parameter(title: "State", default: .system)
	var state: AppRegistrationStateAppEnum

	@Parameter(
		title: "Ignore TrollCuts",
		default: true
	)
	var ignoreSelf: Bool

	static var parameterSummary: some ParameterSummary {
		Summary("Set Apps State to \(\.$state)"){
			\.$ignoreSelf
		}
	}

	func perform() async throws -> some IntentResult {
		if  trollStorePath() != nil {
            switchAllAppsRegistration(state.rawValue.capitalized, ignoreSelf ? ["TrollCuts.app"]: nil)
		} else {
			throw NSError(domain: "TrollCuts", code: 99, userInfo: [NSLocalizedDescriptionKey: "TrollStore not installed."] )
		}
        return .result()
	}
}

enum AppRegistrationStateAppEnum: String, AppEnum {
	case system
	case user

	static let typeDisplayRepresentation: TypeDisplayRepresentation = "App Registration State"

	static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
		.system: "System",
		.user: "User"
	]
}