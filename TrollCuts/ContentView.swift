// Created by udevs

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Open Shortcuts") {
                UIApplication.shared.openURL(URL(string: "shortcuts://create-shortcut")!)
                }
				.buttonStyle(.borderedProminent)
				.controlSize(.small)
				.keyboardShortcut(.defaultAction)
				.padding()
				.dynamicTypeSize(.accessibility1)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
