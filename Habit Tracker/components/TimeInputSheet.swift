//
//  TimeInputSheet.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 11/03/26.
//

import SwiftUI

// MARK: - Time Input Sheet
struct TimeInputSheet: View {
    let label: String
    @State private var time = Date()
    // MARK: Binding -> access parent State (formRow showPopup)
    @Binding var isPresented: Bool
    var onDone: (String) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Select time",
                    selection: $time,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding()
                Spacer()
            }
            .padding(.top, 10)
            .navigationTitle(label)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let formatter = DateFormatter()
                        formatter.timeStyle = .short
                        onDone(formatter.string(from: time))
                        isPresented = false
                    }) {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}
