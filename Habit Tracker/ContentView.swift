//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 10/03/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

#Preview {
    // MARK: DUMMY DATA ON LAUNCH - DELETE ON PROD
//    let container = try! ModelContainer(
//            for: Habit.self,
//            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
//        )
//
//    let context = container.mainContext
//
//    context.insert(
//        Habit(
//            name: "Night Run",
//            logo: "figure.walk",
//            startTime: "18:00",
//            endTime: "19:00",
//            habitDescription: "",
//            habitType: .old
//        )
//    )
//    context.insert(
//        Habit(
//            name: "Night Run",
//            logo: "figure.walk",
//            startTime: "18:00",
//            endTime: "19:00",
//            habitDescription: "night run is fun",
//            habitType: .old
//        )
//    )
//
//        return ContentView()
//            .modelContainer(container)
    
// MARK: UNCOMMENT ON PROD
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}
