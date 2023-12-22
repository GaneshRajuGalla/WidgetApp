//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: AppIntentTimelineProvider {
    
    @ObservedObject private var viewModel = ViewModel()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), photo:nil)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, photo:nil)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        await viewModel.getPhotos()
        // 15 min * 96 times = 24 hours
        for hourOffset in 0 ..< 2 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, photo: viewModel.photos?.randomElement())
            print("hourOffset: \(hourOffset), entry:\(entry)")
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent?
    let photo:Photos?
}


struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ContentView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    SimpleEntry(date: .now, configuration: nil, photo: [] as? Photos)
}


// ContentView

struct ContentView: View {
    var entry: Provider.Entry
    var body: some View {
        
        HStack(spacing: 10) {
            if let wrappedEntry = entry.photo {
                // image
                URLImageView(url: URL(string:wrappedEntry.thumbnailURL ?? "")!)
                // text
                Text(wrappedEntry.title ?? "")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.primary)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
    }
}
