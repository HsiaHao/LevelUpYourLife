//
//  ContentView.swift
//  LevelUpYourLife
//
//  Created by 夏英浩 on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var habitStore = HabitDataStorage()
    @StateObject private var scoreStore = ScoreDataStorage()

    var body: some View {
        VStack {
            LifeProgressView(score: $scoreStore.score)
            HabitList(habitList: $habitStore.habits, score: $scoreStore.score) {
                Task {
                    do {
                        try await habitStore.save(habits: habitStore.habits)
                        try await scoreStore.save(scoreData: scoreStore.score)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }.task {
                do {
                    try await habitStore.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }.frame(height: 200)
            Image(.warrior)
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ContentView()
}
