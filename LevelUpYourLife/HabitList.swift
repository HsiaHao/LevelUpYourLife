//
//  HabitList.swift
//  LevelUpYourLife
//
//  Created by 夏英浩 on 9/24/24.
//

import SwiftUI

struct Habit: Identifiable {
    var id = UUID()
    var name: String
}

// test commit
struct HabitList: View {
    @Environment(\.scenePhase) private var scenePhase
    @Binding var habitList: [HabitData]
    @Binding var score: Int

    let saveAction: () -> Void
    @State private var newHabit = ""
    @State private var newHabitScore = 2
    @State private var currentScore = 0

    var body: some View {
        ScrollViewReader { _ in
            List {
                ForEach(habitList) { habit in
                    HStack {
                        Text(habit.habitName)
                        Spacer()
                        Button("+ \(habit.habitScore)") {
                            if score < 100 {
                                score += habit.habitScore
                            }
                        }.foregroundColor(.blue)
                    }
                }.onDelete(perform: delete)
                HStack {
                    TextField("Habit", text: $newHabit)

                    Text("Score: \(newHabitScore)")
                    Stepper("", onIncrement: {
                        newHabitScore += 1
                    }, onDecrement: {
                        newHabitScore -= 1
                    })

                    Button("Done") {
                        habitList.append(HabitData(habitName: newHabit, habitScore: newHabitScore))
                        newHabit = ""
                    }.disabled(newHabit.isEmpty).foregroundColor(.blue)
                }
            }.onChange(of: scenePhase) { _, _ in
                saveAction()
            }.listStyle(.inset)
        }
    }

    func delete(at offsets: IndexSet) {
        print("remove action")
        habitList.remove(atOffsets: offsets)
    }
}

#Preview {
    HabitList(habitList: .constant(HabitData.sampleData), score: Binding<Int>.constant(HabitData.scoreSample), saveAction: {})
}
