//
//  WidgetViewLiveActivity.swift
//  WidgetView
//
//  Created by 김은찬 on 10/28/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetViewAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetViewLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetViewAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetViewAttributes {
    fileprivate static var preview: WidgetViewAttributes {
        WidgetViewAttributes(name: "World")
    }
}

extension WidgetViewAttributes.ContentState {
    fileprivate static var smiley: WidgetViewAttributes.ContentState {
        WidgetViewAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetViewAttributes.ContentState {
         WidgetViewAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetViewAttributes.preview) {
   WidgetViewLiveActivity()
} contentStates: {
    WidgetViewAttributes.ContentState.smiley
    WidgetViewAttributes.ContentState.starEyes
}
