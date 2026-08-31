//
//  LogoPickerSheet.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 11/03/26.
//

import SwiftUI

// MARK: - Logo Picker Sheet
struct LogoPickerSheet: View {
    // MARK: Binding -> access parent State (formRow selectedLogo) AND (formRow showPopup)
    @Binding var selectedLogo: String
    @Binding var isPresented: Bool

    // MARK: List of Logo
    let sfSymbols: [String] = [
        "figure.run",
        "fork.knife",
        "moon.fill",
        "dumbbell.fill",
        "gamecontroller.fill",
        "paintbrush.pointed.fill",
        "book.fill",
        "music.note",
        "soccerball",
        "bicycle",
        "figure.badminton",
        "fuelpump",
        "tram",
        "dollarsign",
        "cup.and.saucer.fill",
        "figure.mind.and.body",
//        "laptopcomputer",
//        "pills.fill",
//        "sun.max.fill",
//        "figure.yoga"
    ]

    // MARK: Column Size
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(sfSymbols, id: \.self) { symbol in
                        Button(action: {
                            selectedLogo = symbol
                            isPresented = false
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(selectedLogo == symbol
                                          ? Color.blue.opacity(0.15)
                                          : Color(UIColor.systemGray6))
                                    .frame(width: 72, height: 72)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(selectedLogo == symbol
                                                    ? Color.blue
                                                    : Color.clear, lineWidth: 2)
                                    )
                                Image(systemName: symbol)
                                    .font(.system(size: 30))
                                    .foregroundColor(selectedLogo == symbol ? .blue : .primary)
                            }
                        }
                    }
                }
                .padding(20)
            }
            .navigationTitle("Choose Logo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 26))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
