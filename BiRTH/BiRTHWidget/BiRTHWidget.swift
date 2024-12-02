//
//  BiRTHWidget.swift
//  BiRTHWidget
//
//  Created by chanu on 11/24/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    //let name: String        // 사용자 이름
    //let daysUntilBirthday: Int // 생일까지 남은 일수
    //let formattedDate: String  // 생일 날짜 형식 .
}

//보여지는 프론트.
struct BiRTHWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    //entry라는 친구는 위젯이 화면에 보여줄 데이터를 가져오는 역할. Provider가 가져오고 entry에 데이터를 담는다.

    var body: some View {
        sizeBody() // 위젯 크기에 따라 다른 뷰를 반환함.
        //https://nsios.tistory.com/156
    }
    
    @ViewBuilder
        func sizeBody() -> some View {
            switch family {
            ///작은 위젯
            case .systemSmall:
                ZStack {
                    Image("beforesunrise")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 169, height: 169)
                    ZStack{
                        Rectangle().frame(width:169,height:65).padding(.top,93).opacity(0.4)
                        VStack {
                            Spacer()
                            HStack{
                                Spacer()
                                Text("임찬우")
                                    .font(.biRTH_bold_16)
                                    .foregroundColor(.white)
                            }
                            HStack{
                                Spacer()
                                Text("🎂 D-24")
                                    .font (.biRTH_bold_28)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .padding(.top,85)
                    }
                }

            ///큰 위젯
            case .systemLarge:
                ZStack {
                    Image("yaho")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 360, height: 378)
                    ZStack{
                        Rectangle().frame(width:360,height:145).padding(.top,210).opacity(0.4)
                        VStack {
                            Spacer()
                            HStack{
                                Spacer()
                                Text("시네필")
                                    .font(.biRTH_bold_36)
                                    .foregroundColor(.white)
                                    .padding(.trailing,11)
                                    .padding(.bottom,-33)
                                
                                
                                
                            }
                            HStack{
                                Spacer()
                                Text("🎂 D-221")
                                    .font(.biRTH_bold_60)
                                    .foregroundColor(.white)
                                    .padding(.trailing,11)
                                    .padding(.bottom,-18)
                            }
                            
                            HStack{
                                Spacer()
                                Text("05.14(금)")
                                    .font(.biRTH_bold_24)
                                    .foregroundColor(.biRTH_text1)
                                    .padding(.trailing,11)
                                
                            }
                        }
                        .padding()
                        .padding(.bottom, 11)
                    }
                }

            default:
                EmptyView()
            }
        }
}
//widget을 시작하는 부분.
struct BiRTHWidget: Widget {
    let kind: String = "BiRTHWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            BiRTHWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.configurationDisplayName("BiRTH")
        .description("가장 생일이 가까운 친구를 알려드릴게요!")
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}
    
extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    BiRTHWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
    
}
