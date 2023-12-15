//
//  InWaveWidget.swift
//  InWaveWidget
//
//  Created by Laurent Droguet on 13/12/2023.
//  Copyright © 2023 InWave . All rights reserved.
//

import WidgetKit
import SwiftUI
import DesignSystem
import Core

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), breaths:[
            (BreathList.cardiacCoherence.image, BreathList.cardiacCoherence.name),
            (BreathList.forSevenEight.image, BreathList.forSevenEight.name)])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), breaths: [
            (BreathList.cardiacCoherence.image, BreathList.cardiacCoherence.name),
            (BreathList.forSevenEight.image, BreathList.forSevenEight.name)])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(.init(entries: [.init(date: .now,
                                         breaths: [
                                            (BreathList.cardiacCoherence.image, BreathList.cardiacCoherence.name),
                                            (BreathList.forSevenEight.image, BreathList.forSevenEight.name)])],
                         policy: .atEnd))
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let breaths: [(image: String, title: String)]
}

struct InWaveWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        ZStack {
            switch widgetFamily {
            case .systemMedium:
                mediumWidgetView()
            default:
                smallWidgetView()
            }
        }
    }

    func smallWidgetView() -> some View {
        breathView(image: entry.breaths[0].image, title: entry.breaths[0].title)
    }

    func mediumWidgetView() -> some View {
        HStack(spacing: 32) {
            breathView(image: entry.breaths[0].image, title: entry.breaths[0].title)
            breathView(image: entry.breaths[1].image, title: entry.breaths[1].title)
        }
    }

    func breathView(image: String, title: String) -> some View {
        Link(destination: URL(safeString: "www.inwave.com/breath/\(image)")) {
            VStack(spacing: 0) {
                Image(image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.bottom, 8)
                    .shadow(radius: 10)
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.detail())
                    .foregroundColor(.white)
                    .frame(height: 50, alignment: .top)
            }
            .frame(width: 100)
        }
    }
}

struct InWaveWidget: Widget {
    let kind: String = "InWaveWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                InWaveWidgetEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.Background.primary()
                    }
            } else {
                InWaveWidgetEntryView(entry: entry)
                    .background(Color.Background.primary())
            }
        }
        .configurationDisplayName("Tes respirations")
        .description("Pratique pour accéder directement aux exercices les plus populaires")
        .supportedFamilies([.systemSmall, .systemMedium])
        
    }
}

#Preview(as: .systemMedium) {
    InWaveWidget()
} timeline: {
    SimpleEntry(date: .now,
                breaths: [(BreathList.cardiacCoherence.image, BreathList.cardiacCoherence.name), 
                          (BreathList.forSevenEight.image, BreathList.forSevenEight.name)])
}
