//
//  LifeProgressView.swift
//  LevelUpYourLife
//
//  Created by 夏英浩 on 9/23/24.
//

import SwiftUI

struct LifeProgressView: View {
    @Binding var score: Int

    var body: some View {
        let progressData = ["20", "40", "60", "80", "100"]
        let reachedGoal = getCurrentScoreSection(score: score)
        VStack {
            HStack {
                ForEach(progressData, id: \.self) {
                    item in
                    Spacer()
                    VStack {
                        if item == reachedGoal {
                            Text("🎉")
                            Text(item)
                        } else {
                            Text("⍟")
                            Text(item)
                        }
                    }
                }
            }
            ProgressView(value: Double(score), total: 100)
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

private func getCurrentScoreSection(score: Int) -> String {
    if score >= 20 && score < 40 {
        return "20"
    } else if score >= 40 && score < 60 {
        return "40"
    } else if score >= 60 && score < 80 {
        return "60"
    } else if score >= 80 && score < 100 {
        return "80"
    } else if score == 100 {
        return "100"
    } else {
        return "0"
    }
}

#Preview {
    LifeProgressView(score: .constant(HabitData.scoreSample))
}
