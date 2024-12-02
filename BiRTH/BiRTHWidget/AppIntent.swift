//
//  AppIntent.swift
//  BiRTHWidget
//
//  Created by chanu on 11/24/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "BiRTh" }
    static var description: IntentDescription { "친구들의 생일을 위젯으로 편하게 표시해 드려요." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
