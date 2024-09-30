//
//  HabitData.swift
//  LevelUpYourLife
//
//  Created by 夏英浩 on 9/25/24.
//

import Foundation

struct HabitData: Identifiable, Codable {
    let id: UUID
    let habitName: String
    let habitScore: Int

    init(id: UUID = UUID(), habitName: String, habitScore: Int) {
        self.id = id
        self.habitName = habitName
        self.habitScore = habitScore
    }
}

extension HabitData {
    static let sampleData: [HabitData] =
        [
            HabitData(
                habitName: "Exercising", habitScore: 2),
            HabitData(
                habitName: "Working out", habitScore: 2),
        ]
}

extension HabitData {
    static let scoreSample: Int = 40
}
