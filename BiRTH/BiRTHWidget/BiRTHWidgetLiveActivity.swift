//
//  BiRTHWidgetLiveActivity.swift
//  BiRTHWidget
//
//  Created by chanu on 11/24/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BiRTHWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BiRTHWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BiRTHWidgetAttributes.self) { context in
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

extension BiRTHWidgetAttributes {
    fileprivate static var preview: BiRTHWidgetAttributes {
        BiRTHWidgetAttributes(name: "World")
    }
}

extension BiRTHWidgetAttributes.ContentState {
    fileprivate static var smiley: BiRTHWidgetAttributes.ContentState {
        BiRTHWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BiRTHWidgetAttributes.ContentState {
         BiRTHWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BiRTHWidgetAttributes.preview) {
   BiRTHWidgetLiveActivity()
} contentStates: {
    BiRTHWidgetAttributes.ContentState.smiley
    BiRTHWidgetAttributes.ContentState.starEyes
}
