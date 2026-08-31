//
//  TextInputSheet.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 11/03/26.
//

import SwiftUI

// MARK: - Text Input Sheet
struct TextInputSheet: View {
    let label: String
    // MARK: Binding -> access parent State (formRow textInput) AND (formRow showPopup)
    @Binding var text: String
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                TextField("Enter \(label.lowercased())...", text: $text)
                    .font(.system(size: 17))
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.top, 20)
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
                    Button(action: { isPresented = false }) {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}
