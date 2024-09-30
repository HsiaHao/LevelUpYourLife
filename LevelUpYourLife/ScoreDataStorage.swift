//
//  ScoreDataStorage.swift
//  LevelUpYourLife
//
//  Created by 夏英浩 on 9/27/24.
//

import Foundation

//
//  HabitDataStorage.swift
//  LevelUpYourLife
//
//  Created by 夏英浩 on 9/25/24.
//

import SwiftUI

@MainActor
class ScoreDataStorage: ObservableObject {
    @Published var score: Int = 0

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
            .appendingPathComponent("score.data")
    }

    func load() async throws {
        let scoreData = Task<Int, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return 0
            }
            let score = try JSONDecoder().decode(Int.self, from: data)
            print("score", score)
            return score
        }
        let score = try await scoreData.value
        self.score = score
    }

    func save(scoreData: Int) async throws {
        let task = Task {
            let scoreData = try JSONEncoder().encode(scoreData)
            let scoreOutFile = try Self.fileURL()
            try scoreData.write(to: scoreOutFile)
        }
        _ = try await task.value
    }
}
