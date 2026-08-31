//
//  HomeView.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 10/03/26.
//

import SwiftUI
import SwiftData

struct HomeView : View {
    // MARK: Icon Inside Habit Circle - DUMMY DATA
    // TODO: GET From Local Storage
    let oldHabitIcons: [(String, CGFloat, CGFloat)] = [
        ("fork.knife",        -20, 56),
        ("moon.fill",         19, 56),
        ("cart.fill",        -50, 34),
        ("figure.run",       -15, 18),
        ("dumbbell.fill",     50, 33),
        ("paintbrush.pointed.fill", 22, 7),
        ("gamecontroller.fill", 60, -4),
    ]
    
    let newHabitIcons: [(String, CGFloat, CGFloat)] = [
        ("bag.fill",          -20, 56),
        ("phone.fill",         19, 56),
        ("laptopcomputer",    -50, 34),
        ("doc.fill",           -15, 18),
        ("trash.fill",         50, 33),
    ]
    
    let finalMixIcons: [(String, CGFloat, CGFloat)] = [
        ("laptopcomputer",    -20, 56),
        ("phone.fill",         19, 56),
        ("dumbbell.fill",     -50, 34),
        ("trash.fill",          -15, 18),
        ("gamecontroller.fill", 50, 33),
        ("figure.run",         22, 7),
        ("paintbrush.pointed.fill", 60, -4),
        ("moon.fill",         -60, -3),
        ("fork.knife",        -25, -19),
    ]
    
    // MARK: Main
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 0) {
                Text("Habit Tracker")
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, 50)
                    .padding(.bottom, 70)
                
                HStack(spacing: 30) {
                    NavigationLink(destination: HabitView(habitType: .old)) {
                        HabitCircle(label: "Old Habit", icons: oldHabitIcons)
                    }
                    .buttonStyle(.plain) // disable blue fill of the component
                    NavigationLink(destination: HabitView(habitType: .new)) {
                        HabitCircle(label: "New Habit", icons: newHabitIcons)
                    }
                    .buttonStyle(.plain) // disable blue fill of the component
                }
                .padding(.bottom, 30)
                
                NavigationLink(destination: HabitView(habitType: .finalMix)) {
                    HabitCircle(label: "Final Mix\nHabit", icons: finalMixIcons)
                }
                .buttonStyle(.plain) // disable blue fill of the component
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

// MARK: For Quick Debugging - DELETE IN PROD
//#Preview {
//    HomeView()
//        .modelContainer(for: Habit.self, inMemory: true)
//}
