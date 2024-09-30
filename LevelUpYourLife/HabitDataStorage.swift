//
//  HabitDataStorage.swift
//  LevelUpYourLife
//
//  Created by 夏英浩 on 9/25/24.
//

import SwiftUI

@MainActor
class HabitDataStorage: ObservableObject {
    @Published var habits: [HabitData] = []

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
            .appendingPathComponent("habit.data")
    }

    func load() async throws {
        let habitDataTask = Task<[HabitData], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let habits = try JSONDecoder().decode([HabitData].self, from: data)
            return habits
        }
        let habits = try await habitDataTask.value
        print("data load", habits)
        if habits.isEmpty {
            self.habits = self.getDefaultList()
        } else {
            self.habits = habits
        }
    }

    func save(habits: [HabitData]) async throws {
        print("habit data saving triggered", habits)
        let task = Task {
            let data = try JSONEncoder().encode(habits)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
        print("habit data saved done")
    }

    func getDefaultList() -> [HabitData] {
        return [
            HabitData(habitName: "execising for 15 mins", habitScore: 2),
            HabitData(habitName: "reading for 15 mins", habitScore: 2),
        ]
    }
}
