//Created by udevs

import AppIntents

public enum SwitchStateAppEnum: String, AppEnum {
	case on
	case off

	public static let typeDisplayRepresentation: TypeDisplayRepresentation = "State"

	public static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
		.on: "On",
		.off: "Off"
	]
}