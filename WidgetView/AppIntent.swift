//
//  AppIntent.swift
//  SwiftSty
//
//  Created by 김은찬 on 10/28/25.
//

// AppIntent.swift 파일
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "위젯 설정"
    
    @Parameter(title: "이모지", default: "😀")
    var favoriteEmoji: String
    
    @Parameter(title: "위젯 색상", default: .pink)
    var widgetColor: WidgetColorType
}
