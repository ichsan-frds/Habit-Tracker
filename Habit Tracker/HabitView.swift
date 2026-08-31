//
//  HabitView.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 10/03/26.
//

import SwiftUI
import SwiftData

struct HabitView: View {
    let habitType: HabitType
    // MARK: @Environment -> Global-scope Variable
    @Environment(\.dismiss) private var dismiss // pre-determined syntax from documentation - close current view
    @Environment(\.modelContext) private var context: ModelContext // pre-determined syntax from documentation - database context from SwiftData
    // MARK: @State -> File-scope Variable
    @State private var showAddHabit: Bool = false
    @State private var selectedID: PersistentIdentifier? = nil

    // MARK: Fetch data from SwiftData
    @Query private var allHabits: [Habit]
    // MARK: Filter Habit List by Habit Type, then Sort by Start Time > End Time
    var habits: [Habit] {
        allHabits
            .filter { allHabits in allHabits.habitType == habitType.rawValue } // full syntax version
//          .filter { $0.habitType == habitType.rawValue } // short syntax version
            .sorted {
                if $0.startTime != $1.startTime {
                    return $0.startTime < $1.startTime
                }
                return $0.endTime < $1.endTime
            }
    }
    // MARK: Current habit based on selectedID (never index-based)
    var currentHabit: Habit? {
        habits.first { $0.id == selectedID }
    }

    var body: some View {
        VStack(alignment: .center) {
            // MARK: Header
            VStack() {
                Text("Habit Tracker")
                    .font(.system(size: 40))
                    .bold()
                Text(habitType.rawValue)
                    .opacity(0.5)
                    .font(.system(size: 32, weight: .medium))
            }
            .padding(.bottom, 50)

            // MARK: If Habit is Empty
            if habits.isEmpty {
                Spacer()
                Text("No habit found,\ncreate yours below")
                    .font(.system(size: 32, weight: .medium))
                    .opacity(0.25)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Spacer()

            // MARK: Habit is Filled
            } else {
                // MARK: Body Scrollable
                TabView(selection: $selectedID) {
                    ForEach(habits) { habit in
                        VStack(spacing: 0) {
                            HStack(spacing: 20) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 26))
                                    .opacity(habits.first?.id == habit.id ? 0 : 1)
                                Circle()
                                    .fill(Color.white)
                                    .stroke(habit.isCompleted ? Color.green : Color.red, lineWidth: 10)
                                    .frame(maxWidth: 290)
                                    .overlay(
                                        Image(systemName: habit.logo)
                                            .font(.system(size: 120))
                                            .foregroundColor(.black)
                                    )
                                    .onTapGesture {
                                        habit.isCompleted.toggle()
                                    }
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 26))
                                    .opacity(habits.last?.id == habit.id ? 0 : 1)
                            }
                            VStack(spacing: 12) {
                                Text(habit.name)
                                    .font(.system(size: 32, weight: .semibold))
                                Text("\(habit.startTime) - \(habit.endTime)")
                                    .opacity(0.5)
                                    .font(.system(size: 26, weight: .semibold))
                                Text(habit.habitDescription.isEmpty ? "" : habit.habitDescription)
                                    .opacity(0.5)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(22)
                        }
                        // MARK: tag -> identifier for each element (page) in forEach
                        .tag(Optional(habit.id))
                    }
                }
                // MARK: Disable TabView Default look, but still scrollable
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 480)
                .onAppear {
                    if selectedID == nil {
                        selectedID = habits.first?.id
                    }
                }
                // MARK: Make sure selectedID always point to a habit, if there is any
                .onChange(of: habits.count) { _, _ in
                    if habits.isEmpty {
                        selectedID = nil
                    } else if !habits.contains(where: { $0.id == selectedID }) {
                        selectedID = habits.first?.id
                    }
                }
            }

            // MARK: Footer
            Spacer()
            HStack {
                // MARK: Delete Habit Button
                Circle()
                    .fill(Color.red)
                    .frame(maxWidth: 50)
                    .overlay(
                        Image(systemName: "trash")
                            .font(.system(size: 26))
                            .bold()
                            .foregroundColor(.white)
                    )
                    .onTapGesture {
                        guard let habitToDelete = currentHabit else { return }
                        // Find next ID before deleting
                        let idx = habits.firstIndex { $0.id == selectedID } ?? 0
                        let nextID = idx > 0 ? habits[idx - 1].id : habits.dropFirst().first?.id
                        selectedID = nextID
                        context.delete(habitToDelete)
                    }
                    .opacity(habitType == .finalMix ? 0 : 1)
                    .disabled(habitType == .finalMix)
                Spacer()
                // MARK: Add Habit Button
                Circle()
                    .fill(Color.blue)
                    .frame(maxWidth: 50)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 26))
                            .bold()
                            .foregroundColor(.white)
                    )
                    .onTapGesture {
                        showAddHabit = true
                    }
                    .opacity(habitType == .finalMix ? 0 : 1)
                    .disabled(habitType == .finalMix)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        // MARK: Disable Default 'Back' Button (Chevron Left)
        .navigationBarBackButtonHidden(true)
        // MARK: Navigation Toolbar Back Button
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Text("Back")
                        .foregroundColor(.blue)
                }
            }
        }
        // MARK: sheet -> View that appears from bottom
        .sheet(isPresented: $showAddHabit) {
            AddHabitSheet(isPresented: $showAddHabit, habitType: habitType)
                .presentationDetents([.medium]) // display height = half screen
                .presentationDragIndicator(.visible) // display draggable line
        }
    }
}

// MARK: - Add Habit Popup
struct AddHabitSheet: View {
    // MARK: Binding -> access parent State (HabitView showAddHabit)/
    @Binding var isPresented: Bool
    let habitType: HabitType

    @Environment(\.modelContext) private var context
    @State private var logo = ""
    @State private var name = ""
    @State private var startTime = ""
    @State private var endTime = ""
    @State private var description = ""

    // MARK: Criteria of a form validness
    var isFormValid: Bool {
        !logo.isEmpty && !name.isEmpty && !startTime.isEmpty && !endTime.isEmpty
    }

    var body: some View {
        NavigationStack {
            // MARK: Popup Body
            List {
                FormRow(label: "Logo",        value: "Required", type: .logo, output: $logo)
                FormRow(label: "Name",        value: "Required", type: .text, output: $name)
                FormRow(label: "Start Time",  value: "Required", type: .time, output: $startTime)
                FormRow(label: "End Time",    value: "Required", type: .time, output: $endTime)
                FormRow(label: "Description", value: "",         type: .text, output: $description)
            }
            // MARK: Popup Footer
            ZStack() {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isFormValid ? Color.blue : Color.gray)
                Text("Save")
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 15)
            .frame(maxHeight: 50)
            // MARK: Insert data into Habit
            .onTapGesture {
                // MARK: guard -> a bit like if, but more readable
                guard isFormValid else { return }
                let habit = Habit(
                    name: name,
                    logo: logo,
                    startTime: startTime,
                    endTime: endTime,
                    habitDescription: description,
                    habitType: habitType
                )
                context.insert(habit)
                
                if habitType == .old {
                    let finalMixCopy = Habit(
                        name: name,
                        logo: logo,
                        startTime: startTime,
                        endTime: endTime,
                        habitDescription: description,
                        habitType: .finalMix
                    )
                    context.insert(finalMixCopy)
                }
                    
                isPresented = false
            }
//          .listStyle(.insetGrouped)
                        // MARK: Popup Header
                        .navigationBarTitleDisplayMode(.inline) // HStack for navigation header
            .navigationTitle("Add Habit")
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

// MARK: For Quick Debugging - DELETE IN PROD
//#Preview {
//    HabitView(habitType: .old)
//        .modelContainer(for: Habit.self, inMemory: true)
//}
