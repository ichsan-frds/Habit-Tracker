//
//  FormRow.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 11/03/26.
//

//
//  FormRow.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 11/03/26.
//

import SwiftUI
// MARK: ROW COMPONENT FOR ADD HABIT POPUP

// MARK: - Form Row Type
enum FormRowType {
    case logo
    case text
    case time
}

// MARK: - Form Row Components Layouting
struct FormRow: View {
    let label: String
    let value: String
    let type: FormRowType
    // MARK: Binding -> access parent State (addHabitSheet logo, startTime, etc.)
    @Binding var output: String
    
    @State private var showPopup = false
    @State private var textInput = ""
    @State private var timeInput = ""
    @State private var selectedLogo = ""
    
    var displayValue: String {
        switch type {
        case .logo:
            return selectedLogo.isEmpty ? value : selectedLogo
        case .text:
            return textInput.isEmpty ? value : textInput
        case .time:
            return timeInput.isEmpty ? value : timeInput
        }
    }
    
    var isFilled: Bool {
        switch type {
        case .logo: return !selectedLogo.isEmpty
        case .text: return !textInput.isEmpty
        case .time: return !timeInput.isEmpty
        }
    }
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 17))
            Spacer()
            Text(displayValue)
                .font(.system(size: 17))
                .foregroundColor(isFilled ? .blue : Color(UIColor.systemGray2))
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(UIColor.systemGray2))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showPopup = true
        }
        .onChange(of: textInput)     { _, newValue in output = newValue }
        .onChange(of: timeInput)     { _, newValue in output = newValue }
        .onChange(of: selectedLogo)  { _, newValue in output = newValue }
        .sheet(isPresented: $showPopup) {
            switch type {
            case .text:
                TextInputSheet(label: label, text: $textInput, isPresented: $showPopup)
                    .presentationDetents([.height(220)])
                    .presentationDragIndicator(.visible)
            case .time:
                TimeInputSheet(label: label, isPresented: $showPopup, onDone: { formatted in
                    timeInput = formatted
                })
                .presentationDetents([.height(320)])
                .presentationDragIndicator(.visible)
            case .logo:
                LogoPickerSheet(selectedLogo: $selectedLogo, isPresented: $showPopup)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
