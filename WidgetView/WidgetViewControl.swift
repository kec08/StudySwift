//
//  WidgetViewControl.swift
//  WidgetView
//
//  Created by 김은찬 on 10/28/25.
//

import AppIntents
import SwiftUI
import WidgetKit

struct WidgetViewControl: ControlWidget {
    static let kind: String = "IntentWidgetKit"

    var body: some ControlWidgetConfiguration {
        AppIntentControlConfiguration(
            kind: Self.kind,
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "Start Timer",
                isOn: value.isRunning,
                action: StartTimerIntent(value.name)
            ) { isRunning in
                Label(isRunning ? "On" : "Off", systemImage: "timer")
            }
        }
        .displayName("Timer")
        .description("A an example control that runs a timer.")
    }
}



extension WidgetViewControl {
    struct Value {
        var isRunning: Bool
        var name: String
    }

    struct Provider: AppIntentControlValueProvider {
        func previewValue(configuration: TimerConfiguration) -> Value {
            WidgetViewControl.Value(isRunning: false, name: configuration.timerName)
        }

        func currentValue(configuration: TimerConfiguration) async throws -> Value {
            let isRunning = true // Check if the timer is running
            return WidgetViewControl.Value(isRunning: isRunning, name: configuration.timerName)
        }
    }
}

struct TimerConfiguration: ControlConfigurationIntent {
    static let title: LocalizedStringResource = "Select Color"

    @Parameter(title: "Timer Name", default: "Timer")
    var timerName: String
    
    @Parameter(title: "color",default: .redType)
        var type : SelectColorType
}

enum SelectColorType: String, AppEnum {
    case redType, blueType, orangeType

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Color Type"
    static var caseDisplayRepresentations: [SelectColorType : DisplayRepresentation] = [
        .redType: "Red",
        .blueType:"Blue",
        .orangeType: "Oragnge",
    ]
}



struct StartTimerIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Start a timer"

    @Parameter(title: "Timer Name")
    var name: String

    @Parameter(title: "Timer is running")
    var value: Bool

    init() {}

    init(_ name: String) {
        self.name = name
    }

    func perform() async throws -> some IntentResult {
        // Start the timer…
        return .result()
    }
}
