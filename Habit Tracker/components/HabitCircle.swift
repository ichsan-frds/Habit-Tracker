//
//  HabitCircle.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 11/03/26.
//

import SwiftUI
// MARK: CIRCLE FILLED WITH HABIT ICONS IN HOME VIEW

struct HabitCircle: View {
    let label: String
    // MARK: Description -> (systemName, xOffset, yOffset)
    let icons: [(String, CGFloat, CGFloat)]

    var body: some View {
        VStack() {
            ZStack {
                // MARK: Background circle
                Circle()
                    .fill(Color.white)
                    .frame(maxWidth: 160)
                    .shadow(radius: 15)

                // MARK: Floating icon bubbles
                ForEach(icons.indices, id: \.self) { i in
                    let item = icons[i]
                    Circle()
                        .fill(Color.white)
                        .frame(maxWidth: 38)
                        .shadow(color: .black.opacity(0.12), radius: 5, x: 2, y: 3)
                        .overlay(
                            Image(systemName: item.0)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        )
                        .offset(x: item.1, y: item.2)
                }
            }

            Text(label)
                .font(.system(size: 20, weight: .medium))
                .multilineTextAlignment(.center)
        }
    }
}
